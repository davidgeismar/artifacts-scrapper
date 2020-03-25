module Christies
  log_file = File.open("./log/christies.log", "w")
  LOGGER = Logger.new MultiIO.new(STDOUT, log_file)
  class Scrapper
    YEAR_RANGE = (1998..2020)
    MONTH_RANGE = (1..12)

    def initialize(months=nil, years=nil)
      # cleaning logs every time the scrapper is launched
      # File.truncate('./log/christies.log', 0)
      $stderr.reopen("./log/err.log", "w") if ENV['ARTIFACTS_ENV'] == 'docker_production'
      @agent = Mechanize.new
      @agent.redirect_ok = false
      @errors = []
      @years = years || (1998..2020)
      @months = months || (1..12)
    end

    def run
      @years.each do |year|
        @months.each do |month|
          extract_sales(month, year)
        end
      end
    end

    def extract_sales(month, year)
      # for each month we extract all sales
      sales = SalesExtractor.new(month, year).sales
      SalesProcessingJob.new.perform(sales.to_json)
      sales.each do |sale|
        LotsProcessingJob.perform_async(sale['sale_detail']['sale_id'])
      end
    end
  end
end
