module Christies
  class LotsExtractor
    attr_accessor :lots
    def initialize(agent, sale_id, errors_report)
      @agent = agent
      @sale_id = sale_id
      @uri = build_uri
      @lots = get_lots
    end

    private

    def get_lots
      response = HTTParty.post(
        'https://www.christies.com/interfaces/LotFinderAPI/SearchResults.asmx/GetSaleLandingLots',
        { body: { StrUrl: @uri, PageSize: '5000', ClientGuid: '', GeoCountryCode:'GB' , LanguageID: '1', IsLoadAll: '1', SearchType: 'salebrowse' }}
      )
      JSON.parse(response.body)["d"]["LotList"]
    end

    def build_uri
      "https://www.christies.com/Salelanding/index.aspx?intsaleid=#{@sale_id}&lid=1"
    end
  end
end
