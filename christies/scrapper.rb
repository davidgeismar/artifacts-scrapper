module Christies
  log_file = File.open("./log/christies.log", "w")
  LOGGER = Logger.new MultiIO.new(STDOUT, log_file)
  class Scrapper
    YEAR_RANGE = (1998..2020)
    MONTH_RANGE = (1..12)

    def initialize(month=nil, year=nil)
      # cleaning logs every time the scrapper is launched
      # File.truncate('./log/christies.log', 0)
      @agent = Mechanize.new
      @agent.redirect_ok = false
      @errors = []
      @years = year ? [year] : (1998..2010)
      @months = month ? [month] : (1..12)
    end

    def run
      @years.each do |year|
        @months.each do |month|
          extract_sales(month, year)
        end
      end
    end

    def extract_sales(month, year)
      sales = SalesExtractor.new(month, year).sales
      sales.each do |sale|
        payload = build_payload(sale['sale_detail'], month, year)
        SaleProcessingJob.perform_async(payload)
      end
    end

    def build_payload(sale_details, month, year)
      {
        sale: sale_details,
        lots: extract_lots(sale_details['sale_id'], month, year)
      }.to_json
    end

    def extract_lots(sale_id, month, year)
      lots = LotsExtractor.new(@agent, sale_id).lots
      lots.map { |lot| extract_lot(lot) }
    end

    def extract_lot(lot, report=nil)
      lot = LotExtractor.new(@agent, lot)
      lot.data
    end
  end
end
