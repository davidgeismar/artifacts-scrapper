module Christies
  class Lot < ActiveRecord::Base
    after_commit :send_lot_to_api if ENV['WITH_JOBS']

    def send_lot_to_api
      bidning.pry
      LotProcessingJob.perform_async(self.id)
    end

  end
end
