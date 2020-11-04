module Entities
  class ParcelItem < Entities::Base
    expose :id
    expose :name
    expose :description
    expose :count
    expose :item_type, with: Entities::ParcelItemType
  end
end
