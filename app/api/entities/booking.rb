module Entities
  class Booking < API::Entities::Base
    expose :number
    expose :status

    with_options(format_with: :float) do
      expose :price
      expose :dispatcher_proposed_price
      expose :transporter_proposed_price
    end

    expose :currency, with: API::Entities::Currency
    expose :package, with: API::Entities::Package
    expose :trip, with: API::Entities::Trip
    expose :dispatcher, with: API::Entities::User
    expose :transporter, with: API::Entities::User
  end
end
