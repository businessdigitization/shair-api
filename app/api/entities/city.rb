module Entities
  class City < API::Entities::Base
    expose :name
    expose :country, with: API::Entities::Country
  end
end
