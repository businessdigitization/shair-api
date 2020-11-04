module Entities
  class Parcel < Entities::Base
    expose :id
    expose :destination, with: Entities::Airport
    expose :origin, with: Entities::Airport

    expose :dispatcher, with: Entities::User
    expose :status
    expose :description

    with_options(format_with: :float) do
      expose :weight
    end

    expose :items, with: Entities::ParcelItem
    expose :items_categories
    expose :pricing, with: Entities::ParcelPricing
    expose :preference
  end
end
