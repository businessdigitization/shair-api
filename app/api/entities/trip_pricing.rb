module Entities
  class TripPricing < Entities::Base
    expose :id
    with_options(format_with: :float) do
      expose :unit_price
      expose :minimum_price
    end
    expose :currency, with: Entities::Currency
    expose :negotiable
  end
end
