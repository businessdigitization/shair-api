module Entities
  class Booking < Entities::Base
    expose :number
    expose :status

    with_options(format_with: :float) do
      expose :price
      expose :dispatcher_proposed_price
      expose :transporter_proposed_price
    end

    expose :currency, with: Entities::Currency
    expose :parcel, with: Entities::Parcel
    expose :trip, with: Entities::Trip
    expose :dispatcher, with: Entities::User
    expose :transporter, with: Entities::User
  end
end
