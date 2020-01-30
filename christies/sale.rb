# abstract class
module Christies
  class Sale
    attr_accessor :details, :title
    # why not create accessor dynamically for every details key
    def initialize(details)
      @details = details
      @is_online_only = details['is_online_only']
      @end_date = details['sale_end_date']
      @title = details['title']
    end

    def is_online_only?
      @is_online_only
    end

    def is_passed?
      Date.parse(@end_date) < Date.today
    end
  end
end
