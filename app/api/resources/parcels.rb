module Resources
  class Parcels < Grape::API
    resources :parcels do
      desc 'Search Parcel'
      params do
        requires :origin_airport_code, type: String
        requires :destination_airport_code, type: String
      end

      get 'search' do
        parcels = ParcelService::Search.call(permitted_params)
        parcels = Kaminari.paginate_array(parcels)

        present paginate(parcels), with: Entities::Parcel
      end

      desc 'Create a Parcel'
      params do
        requires :origin_airport_code, type: String, values: -> { Airport.pluck(:code) }

        requires :destination_airport_code, type: String, values: -> { Airport.pluck(:code) }

        requires :dispatcher_email, type: String, values: -> { User.pluck(:email) }

        optional :weight, type: Float
        optional :description, type: String
        optional :preference, type: String
        optional :status, type: String

        optional :pricing, as: :pricing_attributes, type: Hash do
          requires :price, type: BigDecimal
          requires :currency_code, type: String
          requires :negotiable, type: Boolean
        end

        optional :items, as: :items_attributes, type: Array do
          requires :count, type: Integer
          requires :name, type: String
          requires :category_id, type: Integer
          optional :description, type: String
        end
      end

      post do
        parcel = Parcel.create!(permitted_params)
        present parcel, with: Entities::Parcel
      end

      route_param :id do
        desc 'Get a parcel'
        get do
          parcel = Parcel.find(params[:id])
          present parcel, with: Entities::Parcel
        end

        desc 'Delete a parcel'
        delete do
          Parcel.find(params[:id]).destroy
          body false
        end

        desc 'Update a parcel'
        params do
          optional :origin_airport_code, type: String, values: -> { Airport.pluck(:code) }

          optional :destination_airport_code, type: String, values: -> { Airport.pluck(:code) }

          optional :dispatcher_email, type: String, values: -> { User.pluck(:email) }

          optional :weight, type: Float
          optional :description, type: String
          optional :preference, type: String
          optional :status, type: String

          optional :pricing, as: :pricing_attributes, type: Hash do
            requires :id, type: Integer
            optional :price, type: BigDecimal
            optional :currency_code, type: String
            optional :negotiable, type: Boolean
          end

          optional :items, as: :items_attributes, type: Array do
            requires :id, type: Integer
            optional :count, type: Integer
            optional :name, type: String
            optional :description, type: String
            optional :category_id, type: Integer
            optional :_destroy, type: Boolean
          end

          optional :new_items, type: Array do
            requires :count, type: Integer
            requires :name, type: String
            requires :category_id, type: Integer
            optional :description, type: String
          end
        end

        patch do
          parcel = ParcelService::Update.call(permitted_params)
          present parcel, with: Entities::Parcel
        end
      end
    end
  end
end
