module Resources
  class ParcelItemCategories < Grape::API
    resources :parcel_item_categories do
      desc 'Get all Parcel Item Categories'

      get do
        parcel_item_category = ParcelItemCategory.all
        parcel_item_category = Kaminari.paginate_array(parcel_item_category)

        present paginate(parcel_item_category), with: Entities::ParcelItemCategory
      end
    end
  end
end
