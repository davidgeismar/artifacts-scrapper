module Christies
  class Lot < ActiveRecord::Base
    after_commit :send_lot_to_api if WITH_JOBS

    def send_lot_to_api
      binding.pry
      LotProcessingJob.perform_async(self.id)
    end
  end
end
