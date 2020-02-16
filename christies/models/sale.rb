module Christies
  class Sale < ActiveRecord::Base
    after_commit :send_to_api, if: ENV['WITH_JOBS']

    def send_to_api
      SaleProcessingJob.perform_async(self.id)
      binding.pry
    end

    def is_online_only
      details['is_online_only']
    end

    def christies_id
      details['sale_id']
    end

    def christies_number
      details['sale_number']
    end

    def end_date
      details['sale_end_date']
    end

    def title
      details['title']
    end
  end
end
