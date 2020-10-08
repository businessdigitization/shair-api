module Resources
  class Trips < Grape::API
    resources :trips do
      desc 'Search trip'
      params do
        requires :origin_airport_code, type: String
        requires :destination_airport_code, type: String
      end

      get 'search' do
        trips = SearchTrip.call(permitted_params)
        trips = Kaminari.paginate_array(trips)

        present paginate(trips), with: API::Entities::Trip
      end

      desc 'Create trips'
      params do
        requires :origin_airport_code, type: String, values: -> { Airport.pluck(:code) }

        requires :destination_airport_code, type: String, values: -> { Airport.pluck(:code) }

        requires :transporter_email, type: String, values: -> { User.pluck(:email) }

        optional :departure_at, type: DateTime
        optional :arrival_at, type: DateTime
        optional :luggage_capacity, type: BigDecimal
        optional :status, type: String

        optional :pricing, as: :pricing_attributes, type: Hash do
          requires :unit_price, type: BigDecimal
          requires :minimum_price, type: BigDecimal
          requires :negotiable, type: Boolean
          requires :currency_code, type: String
        end
        optional :preference, type: String
      end

      post do
        trip = Trip.create(permitted_params)
        present trip, with: Entities::Trip
      end

      route_param :id do
        desc 'Get a trip'
        get do
          trip = Trip.find(params[:id])
          present trip, with: Entities::Trip
        end

        desc 'Delete a trip'
        delete do
          trip = Trip.find(params[:id]).destroy
          body false
        end

        desc 'Update a trip'
        params do
          optional :origin_airport_code, type: String, values: -> { Airport.pluck(:code) }

          optional :destination_airport_code, type: String, values: -> { Airport.pluck(:code) }

          optional :departure_at, type: DateTime
          optional :arrival_at, type: DateTime
          optional :luggage_capacity, type: BigDecimal
          optional :status, type: String

          optional :pricing, as: :pricing_attributes, type: Hash do
            optional :id, type: Integer
            optional :unit_price, type: BigDecimal
            optional :minimum_price, type: BigDecimal
            optional :negotiable, type: Boolean
            optional :currency_code, type: String
          end
          optional :preference, type: String
        end

        patch do
          trip = Trip.find(params[:id])
          trip.update!(permitted_params)
          present trip, with: Entities::Trip
        end
      end
    end
  end
end
