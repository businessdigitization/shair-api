module API
  module Entities
    class City < API::Entities::Base
      expose :id
      expose :name
      expose :country, with: API::Entities::Country
    end
  end
end
