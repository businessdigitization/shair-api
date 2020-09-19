module API
  module Entities
    class Airport < API::Entities::Base
      expose :id
      expose :name
      expose :code
      expose :city, with: API::Entities::City
    end
  end
end