module Christies
  class LotProcessingJob
    include Sidekiq::Worker

    def perform(lot_id)
      lot = Lot.find(lot_id).to_json
      puts("Sending #{lot} to data processing api")
    end
  end
end
