module Christies
  class SaleProcessingJob
    include Sidekiq::Worker

    def perform(sale)
      sale_id = JSON.parse(sale)['sale']["sale_id"]
      # LOGGER.info("sending sale #{sale_id} to artifacts api")
      response = HTTParty.post(
          "#{ENV['DATA_API_BASE']}/christies/sales",
          body: {
            data: sale
          }
        )
      if response.code === 500
        logger.debug "ARTIFACTS DATA API failed to process #{sale}"
        logger.info response
      end
    end
  end
end
