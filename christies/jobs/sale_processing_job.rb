module Christies
  class SaleProcessingJob
    include Sidekiq::Worker

    def perform(sale_id)
      sale = Sale.find(sale_id).to_json
      puts("Sending #{sale} to data processing api")
    end
  end
end
