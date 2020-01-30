require 'httparty'
require 'nokogiri'
require 'mechanize'
require 'pry-byebug'
require 'fileutils'
require 'active_support'

# class EventHasNoIdError < StandardError
# end
class ChristiesScrapper
  def initialize
    @agent = Mechanize.new
    @errors = []
  end

  def get_sales(month, year)
    uri = build_events_uri(month, year)
    results = HTTParty.get(uri)
    JSON.parse(results)['calendar_section']['calendar_items']
  end

  def build_events_uri(month, year)
    "https://www.christies.com/results?month=#{month}&year=#{year}&lid=1&locations=&scids=&initialload=0&actionapply=filter"
  end

  def build_online_sale_uri(sale_id, sale_number)
    "https://onlineonly.christies.com/sso?SaleID=#{sale_id}&SaleNumber=#{sale_number}"
  end

  def build_non_online_sale_uri(sale_id)
    "https://www.christies.com/salelanding/index.aspx?lid=1&intsaleid=#{sale_id}"
  end

  def build_non_online_passed_sale_uri(sale_id)
    "https://www.christies.com/AjaxPages/SaleLanding/DisplayLotList.aspx?lid=1&intsaleid=#{sale_id}"
  end


  def get_online_sale_data(uri)
    page = @agent.get(uri)
    begin
      data = page.search('script')[21].text.scan(/(?<="items": )\[.*?\](?=,)/m).first
      binding.pry
      JSON.parse(data)
    rescue Exception => e
      puts(e.message)
      @errors.push(message: e.message, uri: uri)
      e.message
    end
  end

  def get_not_online_passed_sale_data(uri)
    data = []
    begin
      page = @agent.get(uri)
      titles = get_titles(page)
      subtitles = get_subtitles(page)
      prices_realised = get_price_realised(page)
      titles.each_with_index do |title, index|
        data << {
          title: title.strip,
          subtitles: subtitles[index].strip,
          prices_realised: prices_realised[index].text.strip,
        }
      end
      data.to_json
    rescue Exception => e
      puts(e.message)
      @errors.push(message: e.message, uri: uri)
      e.message
    end
  end

  def get_not_online_sale_data(uri)
    data = []
    begin
      page = @agent.get(uri)
      titles = page.search("span.title1")
      primary_estimates = get_primary_estimates(page)
      secondary_estimates = page.search("p.secondryprice")
      binding.pry
      titles.each_with_index do |title, index|
        data << {
          title: title.text.strip,
          primary_estimates: primary_estimates[index].text.strip,
          secondary_estimates: secondary_estimates[index].text.strip
        }
      end
      data.to_json
    rescue Exception => e
      puts(e.message)
      @errors.push(message: e.message, uri: uri)
      e.message
    end
  end

  def get_titles(page)
      page.search("span.detailscontainer > p.p--primary.font_medium").map{|element| element.text}
  end

  def get_subtitles(page)
    page.search("span.detailscontainer > p.title2").map{|element| element.text}
  end

  def get_price_realised(page)
    page.search("span.priceContainer > p.price > span.price1").select { |element| element.text =~ /Price realised/  }
  end

  def get_primary_estimates(page)
    page.search("div.seperator.seperator-2").map{ |element| element.next_element }.select { |element| element.text =~ /Estimate/  }
  end

  def extract_sale_data(sale)
    if sale['is_online_only']
      uri = build_online_sale_uri(sale['sale_id'], sale['sale_number'])
      { data: get_online_sale_data(uri), uri: uri }
    else
      if Date.parse(sale['sale_end_date']) < Date.today
        uri = build_non_online_passed_sale_uri(sale['sale_id'])
        { data: get_not_online_passed_sale_data(uri), uri: uri }
      else
        uri = build_non_online_sale_uri(sale['sale_id'])
        { data: get_not_online_sale_data(uri), uri: uri }
      end
    end
  end

  def write_sale_data(sale, month, year)
    sale_title = sale['title']
    filepath = "#{year}/#{month}/#{ ActiveSupport::Inflector::underscore(sale_title)}.json"
    file = File.open(filepath, "w")
    sale_data = extract_sale_data(sale)
    file.puts(sale_data[:uri])
    file.puts(sale_data[:data])
  end

  def run
    (1998..2020).each do |year|
      (1..12).each do |month|
        FileUtils.mkdir_p  "#{year}/#{month}"
        sales = get_sales(month, year)
        sales.each do |sale|
          write_sale_data(sale['sale_detail'], month, year)
        end
      end
    end
  end
end

ChristiesScrapper.new.run
