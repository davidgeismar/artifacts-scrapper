module Christies
  class SalesExtractor
    attr_accessor :sales
    def initialize(month, year)
      results = HTTParty.get(build_uri(month, year))
      @sales = JSON.parse(results)['calendar_section']['calendar_items'].map { |sale| Sale.create(details: sale['sale_detail']) }
    end

    private

    def build_uri(month, year)
      "https://www.christies.com/results?month=#{month}&year=#{year}&lid=1&locations=&scids=&initialload=0&actionapply=filter"
    end
  end
end
