module API
  module Entities
    class Booking < API::Entities::Base
      expose :id
      expose :status
      expose :price
      expose :dispatcher_proposed_price
      expose :transporter_proposed_price
      expose :currency, with: API::Entities::Currency
      expose :package, with: API::Entities::Package
      expose :trip, with: API::Entities::Trip
    end
  end
end
