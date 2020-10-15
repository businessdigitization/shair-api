module Resources
  class Packages < Grape::API
    resources :packages do
      desc 'Search Package'
      params do
        requires :origin_airport_code, type: String
        requires :destination_airport_code, type: String
      end

      get 'search' do
        packages = PackageService::Search.call(permitted_params)
        packages = Kaminari.paginate_array(packages)

        present paginate(packages), with: Entities::Package
      end

      desc 'Create a Package'
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
          optional :description, type: String
        end
      end

      post do
        package = Package.create!(permitted_params)
        present package, with: Entities::Package
      end

      route_param :id do
        desc 'Get a package'
        get do
          package = Package.find(params[:id])
          present package, with: Entities::Package
        end

        desc 'Delete a package'
        delete do
          Package.find(params[:id]).destroy
          body false
        end

        desc 'Update a package'
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
            optional :_destroy, type: Boolean
          end

          optional :new_items, type: Array do
            requires :count, type: Integer
            requires :name, type: String
            optional :description, type: String
          end
        end

        patch do
          package = PackageService::Update.call(permitted_params)
          present package, with: Entities::Package
        end

        post 'items' do
          package = Package.find(params[:id])
          package.update!(permitted_params)
          present package, with: Entities::Package
        end
      end
    end
  end
end
