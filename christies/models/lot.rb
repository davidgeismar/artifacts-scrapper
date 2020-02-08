module Christies
  class Lot < ActiveRecord::Base
    after_commit :send_lot_to_api

    def send_lot_to_api
      LotProcessingJob.perform_async(self.id)
    end

  end
end
