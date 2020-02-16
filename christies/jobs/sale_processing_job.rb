module Christies
  class SaleProcessingJob
    include Sidekiq::Worker

    def perform(sale_id)
      sale = Sale.find(sale_id)
      HTTParty.post(
        "#{ENV['DATA_API_BASE']}/sales",
        body: {
          sale: sale.to_json
        }
      )
    end
  end
end
