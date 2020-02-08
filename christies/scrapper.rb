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
          extract_sales(month, year)
        end
      end
    end

    def extract_sales(month, year)
      errors_report = Report.new('errors.json')
      sales = SalesExtractor.new(month, year).sales
      sales.first(2).each do |sale|
        extract_lots(sale, month, year)
      end
    end

    def extract_lots(sale, month, year)
      # report = Report.new("#{year}/#{month}/#{sale.title.parameterize}.json")
      lots = LotsExtractor.new(@agent, sale.christies_id).lots
      lots.each { |lot| extract_lot(lot) }
    end

    def extract_lot(lot, report=nil)
      lot = LotExtractor.new(@agent, lot)
      Lot.create(details: lot.data)
    end
  end
end
