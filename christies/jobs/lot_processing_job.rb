module Christies
  class LotProcessingJob
    include Sidekiq::Worker

    def perform(lot_id)
      lot = Lot.find(lot_id)
      HTTParty.post(
        "#{ENV['DATA_API_BASE']}/sales",
        body: {
          lot: lot.to_json
        }
      )
    end
  end
end
