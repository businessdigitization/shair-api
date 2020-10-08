module Entities
  class City < Entities::Base
    expose :name
    expose :country, with: Entities::Country
  end
end
