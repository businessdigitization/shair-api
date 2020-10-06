module Entities
  class PackageItem < API::Entities::Base
    expose :id
    expose :name
    expose :description
    expose :count
  end
end
