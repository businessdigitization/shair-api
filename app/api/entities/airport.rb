module Entities
  class Airport < API::Entities::Base
    expose :name
    expose :code
    expose :city, with: API::Entities::City
  end
end
