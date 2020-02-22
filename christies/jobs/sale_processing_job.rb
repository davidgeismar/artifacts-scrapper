module Christies
  class SaleProcessingJob
    include Sidekiq::Worker

    def perform(sale)
      HTTParty.post(
        "#{ENV['DATA_API_BASE']}/christies/sales",
        body: {
          data: sale
        }
      )
    end
  end
end
