module API
  module Entities
    class Trip < API::Entities::Base
      expose :id
      expose :destination, with: API::Entities::Airport
      expose :departure, with: API::Entities::Airport

      with_options(format_with: :iso_date) do
        expose :departure_on
      end

      with_options(format_with: :iso_time) do
        expose :departure_time
      end

      with_options(format_with: :iso_time) do
        expose :arrival_time
      end

      expose :transporter, with: API::Entities::User
      expose :status
      expose :luggage_capacity
      expose :pricing, with: API::Entities::TripPricing
      expose :preference
    end
  end
end
