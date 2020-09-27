module API
  module Resources
    class Trips < Grape::API
      resources :trips do
        get do
          trips = Trip.all
          trips = Kaminari.paginate_array(trips)

          present paginate(trips), with: API::Entities::Trip
        end

        desc 'Create trips'
        params do
          requires :departure_airport_code, type: String, values: -> { Airport.pluck(:code) }

          requires :destination_airport_code, type: String, values: -> { Airport.pluck(:code) }

          requires :transporter_email, type: String, values: -> { User.pluck(:email) }

          optional :departure_at, type: DateTime
          optional :arrival_at, type: DateTime
          optional :luggage_capacity, type: BigDecimal

          optional :pricing, type: Hash do
            requires :unit_price, type: BigDecimal
            requires :minimum_price, type: BigDecimal
            requires :negotiable, type: Boolean
            requires :currency_code, type: String
          end
          optional :preference, type: String
        end

        post do
          trip = TripCreateService.call(permitted_params)
          present trip, with: API::Entities::Trip
        end
      end
    end
  end
end
