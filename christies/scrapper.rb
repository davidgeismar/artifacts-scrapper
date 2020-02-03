module Christies
  class Scrapper
    YEAR_RANGE = (1998..2020)
    MONTH_RANGE = (1..12)

    def initialize
      @agent = Mechanize.new
      @agent.redirect_ok = false
      @errors = []
    end

    def run
      [1998].each do |year|
        [1].each do |month|
          FileUtils.mkdir_p  "#{year}/#{month}"
          sales = SalesExtractor.new(month, year).sales
          sales.first(2).each do |sale|
            sale.save!
            errors_report = Report.new('errors.json')
            report = Report.new("#{year}/#{month}/#{sale.title.parameterize}.json")
            lots = LotsExtractor.new(@agent, sale.christies_id, report).lots
            lots.each do |lot|
              lot = LotExtractor.new(@agent, lot, report)
              Lot.create(details: lot.data)
            end
            binding.pry
          end
        end
      end
    end
  end
end
