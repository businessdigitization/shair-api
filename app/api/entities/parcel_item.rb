module Entities
  class ParcelItem < Entities::Base
    expose :id
    expose :name
    expose :description
    expose :count
    expose :category, with: Entities::ParcelItemCategory
  end
end
