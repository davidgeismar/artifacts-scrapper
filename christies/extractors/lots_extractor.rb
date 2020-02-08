require 'net/http'
require 'uri'

module Christies
  class LotsExtractor
    attr_accessor :lots
    def initialize(agent, sale_id, errors_report=nil)
      @agent = agent
      @sale_id = sale_id
      @uri = build_uri
      @lots = get_lots
    end

    private

    def get_lots
      uri = URI.parse("https://www.christies.com/interfaces/LotFinderAPI/SearchResults.asmx/GetSaleLandingLots")
      request = Net::HTTP::Post.new(uri)
      request.content_type = "application/json; charset=UTF-8"
      request["Connection"] = "keep-alive"
      request["Accept"] = "application/json, text/javascript, */*; q=0.01"
      request["Origin"] = "https://www.christies.com"
      request["X-Requested-With"] = "XMLHttpRequest"
      request["User-Agent"] = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36"
      request["Sec-Fetch-Site"] = "same-origin"
      request["Sec-Fetch-Mode"] = "cors"
      request["Referer"] = "https://www.christies.com/impressionist-and-modern-art-26630.aspx?lid=1&dt=010220200512&saletitle=&intsaleid=26630&pg=all&action=paging&sid=c5e00b75-2088-47cd-97d2-32c7bc6cef1e"
      request["Accept-Language"] = "en-US,en;q=0.9,fr;q=0.8"
      request["Cookie"] = "ASP.NET_SessionId=j10ok5vifuapfkjoewuaaqxp; website#lang=en; CurrentLanguage=en; s_nr=; _gcl_au=1.1.1437115274.1580091006; AMCVS_04868BE156B07C737F000101%40AdobeOrg=1; s_ecid=MCMID%7C48977665365061565530248408876525809883; s_cc=true; __troRUID=8316db8d-dc20-43a8-aaf1-edb8d243c2f8; __qca=P0-891814718-1580091007625; sandy-client-id=620c994af720c9e2; _ga=GA1.2.1712494151.1580091025; FastSignup=FastSignupCreated; gig_bootstrap_2_NsqQWOfVjp_4yuA7paAzYbdyyyHE03dA3DzJDkS-pA8CVIiTwM93o-nDE4Ys2gFI=ver2; SessionGUID=15bc0f31-5cb0-49d2-92af-cc60fd0421cb; sitecoreGUID=%7B%22sitecoreGUID%22%3A%22%7B7C127141-370D-4D84-9605-4514BB44E496%7D%22%2C%22Domain%22%3A%22christies.com%22%2C%22PageVisited%22%3A%22https%3A//www.christies.com/privatesales/index%3Flid%3D1%26sc_lang%3Den%22%2C%22Location%22%3A%22%22%7D; chPreviousPage=%7B%22Title%22%3A%22%22%2C%22URL%22%3A%22https%3A//www.christies.com/privatesales/index%3Flid%3D1%26sc_lang%3Den%22%2C%22Domain%22%3A%22christies.com%22%7D; OptanonAlertBoxClosed=2020-01-27T02:26:08.113Z; dtCookie=3$5772CA4B07BDBA62971B378C1B1DBA24; __troSYNC=1; _gid=GA1.2.1727029718.1580567093; AMCV_04868BE156B07C737F000101%40AdobeOrg=1406116232%7CMCIDTS%7C18294%7CMCMID%7C48977665365061565530248408876525809883%7CMCAAMLH-1581194369%7C6%7CMCAAMB-1581194369%7CRKhpRz8krg2tLO6pguXWp5olkAcUniQYPHaMWWgdJ3xzPWQmdj0y%7CMCOPTOUT-1580596769s%7CNONE%7CMCAID%7CNONE%7CvVersion%7C2.5.0; WebClientId=0; cba=; s_sq=%5B%5BB%5D%5D; s_gpv_v83=no%20value; QSI_HistorySession=https%3A%2F%2Fwww.christies.com%2Fbuying-services%2Fbuying-guide%2Ffinancial-information%2F~1580091014811%7Chttps%3A%2F%2Fwww.christies.com%2Fprivatesales%2Findex%3Flid%3D1%26sc_lang%3Den~1580091025394%7Chttps%3A%2F%2Fwww.christies.com%2Fprivatesales%2Findex%2Fimpressionist-and-modern-art%2F%3FPID%3Dmslp_related_features2~1580091033611%7Chttps%3A%2F%2Fwww.christies.com%2Ffeatures%2FThe-Woman-in-Gold-7494-1.aspx%3FPID%3Dmslp_related_features2~1580091055340%7Chttps%3A%2F%2Fwww.christies.com%2Fprivatesales%2Findex%3Flid%3D1%26sc_lang%3Den~1580091116030%7Chttps%3A%2F%2Fwww.christies.com%2Fcalendar%3Fmode%3D1%26sc_lang%3Den%26lid%3D1~1580091893773%7Chttps%3A%2F%2Fwww.christies.com%2F~1580566923657%7Chttps%3A%2F%2Fwww.christies.com%2Fcalendar%3Fmode%3D1%26sc_lang%3Den%26lid%3D1~1580566933221%7Chttps%3A%2F%2Fwww.christies.com%2Flotfinder%2FLot%2Fpablo-picasso-1881-1973-femme-debout-5993781-details.aspx~1580589580971%7Chttps%3A%2F%2Fwww.christies.com%2FFeatures%2FPicasso-prints-guide-10144-1.aspx~1580589669731%7Chttps%3A%2F%2Fwww.christies.com%2Flotfinder%2Fprints-multiples%2Fpablo-picasso-le-repas-frugal-5584721-details.aspx%3Ffrom%3Dsearchresults%26intObjectID%3D5584721%26sid%3Dde58cd25-dfb2-429f-88c7-74e5a1fb956b~1580589760799%7Chttps%3A%2F%2Fwww.christies.com%2Fcalendar%3Fmode%3D1%26sc_lang%3Den%26lid%3D1~1580589808190%7Chttps%3A%2F%2Fwww.christies.com%2FResults~1580589820487%7Chttps%3A%2F%2Fwww.christies.com%2Ffine-and-rare-wines-5688.aspx%3Flid%3D1%26dt%3D010220200343%26saletitle%3D~1580589841243%7Chttps%3A%2F%2Fwww.christies.com%2Fcalendar%3Fmode%3D1%26sc_lang%3Den%26lid%3D1~1580595132248%7Chttps%3A%2F%2Fwww.christies.com%2FResults~1580595133274%7Chttps%3A%2F%2Fwww.christies.com%2Fimpressionist-and-modern-art-26630.aspx%3Flid%3D1%26dt%3D010220200512%26saletitle%3D~1580595203902; OptanonConsent=landingPath=NotLandingPage&datestamp=Sat+Feb+01+2020+22%3A13%3A55+GMT%2B0000+(Greenwich+Mean+Time)&version=4.1.0&EU=true&groups=0_163788%3A1%2C1%3A1%2C2%3A1%2C0_168836%3A1%2C0_168080%3A1%2C0_168082%3A1%2C3%3A1%2C0_168085%3A1%2C0_168079%3A1%2C4%3A1%2C0_168086%3A1%2C0_169685%3A1%2C0_168083%3A1%2C0_168837%3A1%2C0_168838%3A1%2C0_168842%3A1%2C0_168846%3A1%2C0_168851%3A1%2C0_163785%3A1%2C0_168843%3A1%2C0_168847%3A1%2C0_168852%3A1%2C0_168840%3A1%2C0_168844%3A1%2C0_168848%3A1%2C0_168853%3A1%2C0_168841%3A1%2C0_163787%3A1%2C0_168845%3A1%2C0_168081%3A1%2C0_168849%3A1%2C0_168850%3A1%2C8%3A1%2C101%3A1%2C102%3A1%2C104%3A1%2C105%3A1%2C106%3A1%2C108%3A1%2C109%3A1%2C110%3A1%2C111%3A1%2C113%3A1%2C114%3A1%2C116%3A1%2C117%3A1%2C118%3A1%2C119%3A1%2C120%3A1%2C121%3A1%2C122%3A1%2C124%3A1%2C125%3A1%2C126%3A1%2C128%3A1%2C129%3A1%2C130%3A1&AwaitingReconsent=false; mbox=PC#4cafcc029a9f473d812a7d273154d499.21_0#1581804836|session#abda17ac26584a8a8dade286f0224abe#1580597096|check#true#1580595296; __trossion=1580091006_1800_5_8316db8d-dc20-43a8-aaf1-edb8d243c2f8%3A1580589569_8316db8d-dc20-43a8-aaf1-edb8d243c2f8%3A1580595132_1580595237_4_; s_ptc=0.01%5E%5E0.00%5E%5E0.00%5E%5E0.00%5E%5E1.39%5E%5E0.00%5E%5E2.00%5E%5E0.04%5E%5E3.45"
      request.body = "{ 'StrUrl' : '#{@uri}', 'PageSize' :'5000', 'ClientGuid' :'','GeoCountryCode' :'GB' ,'LanguageID' :'1', 'IsLoadAll' :'1' , 'SearchType' : 'salebrowse' }"

      req_options = {
        use_ssl: uri.scheme == "https",
      }

      response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        http.request(request)
      end
      JSON.parse(response.body)["d"]["LotList"]
    end
    # def get_lots
    #   response = HTTParty.post(
    #     'https://www.christies.com/interfaces/LotFinderAPI/SearchResults.asmx/GetSaleLandingLots',
    #      body: { StrUrl: @uri, PageSize: '5000', ClientGuid: '', GeoCountryCode:'GB' , LanguageID: '1', IsLoadAll: '1', SearchType: 'salebrowse' },
    #      headers: {
    #        'Content-Type' => 'application/json; charset=UTF-8',
    #        'Accept' => 'application/json, text/javascript, */*; q=0.01',
    #        'Origin' => 'https://www.christies.com',
    #        'X-Requested-With' => 'XMLHttpRequest',
    #        'Cookie' => "ASP.NET_SessionId=j10ok5vifuapfkjoewuaaqxp; website#lang=en; CurrentLanguage=en; s_nr=; _gcl_au=1.1.1437115274.1580091006; AMCVS_04868BE156B07C737F000101%40AdobeOrg=1; s_ecid=MCMID%7C48977665365061565530248408876525809883; s_cc=true; __troRUID=8316db8d-dc20-43a8-aaf1-edb8d243c2f8; __qca=P0-891814718-1580091007625; sandy-client-id=620c994af720c9e2; _ga=GA1.2.1712494151.1580091025; FastSignup=FastSignupCreated; gig_bootstrap_2_NsqQWOfVjp_4yuA7paAzYbdyyyHE03dA3DzJDkS-pA8CVIiTwM93o-nDE4Ys2gFI=ver2; SessionGUID=15bc0f31-5cb0-49d2-92af-cc60fd0421cb; OptanonAlertBoxClosed=2020-01-27T02:26:08.113Z; dtCookie=3$5772CA4B07BDBA62971B378C1B1DBA24; WebClientId=0; cba=; ReturnToPage=/LotFinder/Search.aspx?searchtype%3dU; ReturnToSearchResults=/LotFinder/Search.aspx?searchtype%3dU; sitecoreGUID=%7B%22sitecoreGUID%22%3A%22%7B0366E41A-AEC0-4D8E-8D23-900246344237%7D%22%2C%22Domain%22%3A%22christies.com%22%2C%22PageVisited%22%3A%22https%3A//www.christies.com/privatesales/index/post-war-and-contemporary-art%3FPID%3Dmslp_related_features1%22%2C%22Location%22%3A%22%22%7D; chPreviousPage=%7B%22Title%22%3A%22%22%2C%22URL%22%3A%22https%3A//www.christies.com/privatesales/index/post-war-and-contemporary-art%3FPID%3Dmslp_related_features1%22%2C%22Domain%22%3A%22christies.com%22%7D; ReturnToPage=https://www.christies.com/lotfinder/paintings/george-grosz-gefahrliche-strabe-6252177-details.aspx; AMCV_04868BE156B07C737F000101%40AdobeOrg=1406116232%7CMCIDTS%7C18299%7CMCMID%7C48977665365061565530248408876525809883%7CMCAAMLH-1581612485%7C6%7CMCAAMB-1581612485%7CRKhpRz8krg2tLO6pguXWp5olkAcUniQYPHaMWWgdJ3xzPWQmdj0y%7CMCOPTOUT-1581014885s%7CNONE%7CMCAID%7CNONE%7CvVersion%7C2.5.0; __troSYNC=1; s_sq=%5B%5BB%5D%5D; OptanonConsent=landingPath=NotLandingPage&datestamp=Thu+Feb+06+2020+16%3A49%3A45+GMT%2B0000+(Greenwich+Mean+Time)&version=4.1.0&EU=true&groups=0_163788%3A1%2C1%3A1%2C2%3A1%2C0_168836%3A1%2C0_168080%3A1%2C0_168082%3A1%2C3%3A1%2C0_168085%3A1%2C0_168079%3A1%2C4%3A1%2C0_168086%3A1%2C0_169685%3A1%2C0_168083%3A1%2C0_168837%3A1%2C0_168838%3A1%2C0_168842%3A1%2C0_168846%3A1%2C0_168851%3A1%2C0_163785%3A1%2C0_168843%3A1%2C0_168847%3A1%2C0_168852%3A1%2C0_168840%3A1%2C0_168844%3A1%2C0_168848%3A1%2C0_168853%3A1%2C0_168841%3A1%2C0_163787%3A1%2C0_168845%3A1%2C0_168081%3A1%2C0_168849%3A1%2C0_168850%3A1%2C8%3A1%2C101%3A1%2C102%3A1%2C104%3A1%2C105%3A1%2C106%3A1%2C108%3A1%2C109%3A1%2C110%3A1%2C111%3A1%2C113%3A1%2C114%3A1%2C116%3A1%2C117%3A1%2C118%3A1%2C119%3A1%2C120%3A1%2C121%3A1%2C122%3A1%2C124%3A1%2C125%3A1%2C126%3A1%2C128%3A1%2C129%3A1%2C130%3A1&AwaitingReconsent=false; mbox=PC#4cafcc029a9f473d812a7d273154d499.26_0#1582217386|check#true#1581007846|session#d01c1e609ed34466bd4593dd6ab8bf87#1581009646; s_gpv_v83=no%20value; __trossion=1580091006_1800_9_8316db8d-dc20-43a8-aaf1-edb8d243c2f8%3A1580684411_8316db8d-dc20-43a8-aaf1-edb8d243c2f8%3A1581007688_1581007787_6_; s_ptc=0.01%5E%5E0.00%5E%5E0.00%5E%5E0.00%5E%5E3.15%5E%5E0.00%5E%5E1.87%5E%5E0.05%5E%5E5.08; QSI_HistorySession=https%3A%2F%2Fwww.christies.com%2F404.aspx~1580599192911%7Chttps%3A%2F%2Fwww.christies.com%2Flotfinder%2Fsearchresults.aspx%3Fsearchtype%3DU~1580599208292%7Chttps%3A%2F%2Fwww.christies.com%2F%3Faspxerrorpath%3D%252Flotfinder%252Flot_details.aspx~1580647392136%7Chttps%3A%2F%2Fwww.christies.com%2Fprivatesales%2Findex%3Flid%3D1%26sc_lang%3Den~1580680366678%7Chttps%3A%2F%2Fwww.christies.com%2Fprivatesales%2Findex%2Fpost-war-and-contemporary-art%3FPID%3Dmslp_related_features1~1580680378639%7Chttps%3A%2F%2Fwww.christies.com%2F~1580680436834%7Chttps%3A%2F%2Fwww.christies.com%2Fcalendar%3Fmode%3D1%26sc_lang%3Den%26lid%3D1~1580680442659%7Chttps%3A%2F%2Fwww.christies.com%2FResults~1580680447976%7Chttps%3A%2F%2Fwww.christies.com%2Finteriors-including-property-from-27616.aspx%3Flid%3D1%26dt%3D020220200454%26saletitle%3D~1580680459763%7Chttps%3A%2F%2Fwww.christies.com%2F~1580684411989%7Chttps%3A%2F%2Fwww.christies.com%2Ffeatures%2FVirtual-tour-Impressionist-and-Modern-Art-at-Christies-London-10273-3.aspx%3Fsc_lang%3Den%26PID%3Den_hp_carousel_1~1580684416145%7Chttps%3A%2F%2Fwww.christies.com%2Flotfinder%2Fpaintings%2Fgeorge-grosz-gefahrliche-strabe-6252177-details.aspx~1580684521428%7Chttps%3A%2F%2Fwww.christies.com%2FFeatures%2F10-things-to-know-about-George-Grosz-7883-1.aspx~1580684556195%7Chttps%3A%2F%2Fwww.christies.com%2F~1581007688418%7Chttps%3A%2F%2Fwww.christies.com%2Fcalendar%3Fmode%3D1%26sc_lang%3Den%26lid%3D1~1581007705082%7Chttps%3A%2F%2Fwww.christies.com%2FResults~1581007707289%7Chttps%3A%2F%2Fwww.christies.com%2Fcontemporary-edition-27594.aspx%3Flid%3D1%26dt%3D060220201148%26saletitle%3D~1581007722731%7Chttps%3A%2F%2Fwww.christies.com%2FResults%3Fyear%3D2018~1581007768837%7Chttps%3A%2F%2Fwww.christies.com%2Fimpressionist-and-modern-works-27395.aspx%3Flid%3D1%26dt%3D060220201149%26saletitle%3D~1581007788033"
    #      }
    #   )
    #   binding.pry
    #   JSON.parse(response.body)["d"]["LotList"]
    # end

    def build_uri
      "https://www.christies.com/Salelanding/index.aspx?intsaleid=#{@sale_id}&lid=1"
    end
  end
end
