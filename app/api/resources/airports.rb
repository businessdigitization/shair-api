module Resources
  class Airports < Grape::API
    resources :airports do

      desc 'Search Airport'
      params do
        requires :query, type: String
      end

      get 'search' do
        airports = SearchAirport.call(permitted_params[:query])
        airports = Kaminari.paginate_array(airports)

        present paginate(airports), with: Entities::Airport
      end
    end
  end
end
