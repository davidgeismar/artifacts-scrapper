module Christies
  class LotProcessingJob
    include Sidekiq::Worker

    def perform(lot, sale_id)
      begin
        retries ||= 0
        lot = LotExtractor.new(Mechanize.new, lot)
      rescue StandardError => e
        retry if (retries += 1) < 3
        logger.info("#{e.message}")
        return nil
      end
      response = HTTParty.post(
          "#{ENV['DATA_API_BASE']}/christies/lots",
          body: {
            data: lot.data.to_json
          }
        )
      if response.code === 500
        logger.debug "ARTIFACTS DATA API failed to process #{lot}"
        logger.info response
      end
    end
  end
end
