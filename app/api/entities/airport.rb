module Entities
  class Airport < Entities::Base
    expose :name
    expose :code
    expose :city, with: Entities::City
  end
end
