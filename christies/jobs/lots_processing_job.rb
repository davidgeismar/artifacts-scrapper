module Christies
  class LotsProcessingJob
    include Sidekiq::Worker

    def perform(sale_id)
      lots = LotsExtractor.new(Mechanize.new, sale_id).lots
      lots.each do |lot|
        LotProcessingJob.perform_async(lot.to_json, sale_id)
      end
    end
  end
end
