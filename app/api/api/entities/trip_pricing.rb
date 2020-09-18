module API
  module Entities
    class TripPricing < API::Entities::Base
      expose :unit_price
      expose :minimum_price
      expose :currency, with: API::Entities::Currency
      expose :negotiable
    end
  end
end
