module Entities
  class Currency < API::Entities::Base
    expose :name
    expose :code
  end
end
