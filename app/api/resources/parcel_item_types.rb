module Resources
  class ParcelItemTypes < Grape::API
    resources :parcel_item_types do
      desc 'Get all Parcel Item Types'

      get do
        parcle_item_types = ParcelItemType.all
        parcle_item_types = Kaminari.paginate_array(parcle_item_types)

        present paginate(parcle_item_types), with: Entities::ParcelItemType
      end
    end
  end
end
