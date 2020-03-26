module Christies
  class SalesProcessingJob
    include Sidekiq::Worker

    def perform(sales)
      # LOGGER.info("sending sale #{sale_id} to artifacts api")
      response = HTTParty.post(
          "#{ENV['DATA_API_BASE']}/christies/sales/bulk_month",
          body: {
            data: sales
          }
        )
      if response.code === 500
        logger.debug "ARTIFACTS DATA API failed to process #{sales}"
        logger.info response
      end
    end
  end
end
