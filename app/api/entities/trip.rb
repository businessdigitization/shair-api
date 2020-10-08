module Entities
  class Trip < Entities::Base
    expose :id
    expose :destination, with: Entities::Airport
    expose :origin, with: Entities::Airport

    with_options(format_with: :iso_time) do
      expose :departure_at
      expose :arrival_at
    end

    expose :transporter, with: Entities::User
    expose :status
    expose :luggage_capacity
    expose :pricing, with: Entities::TripPricing
    expose :preference
  end
end
