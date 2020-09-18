module API
  module Entities
    class Country < API::Entities::Base
      expose :id
      expose :name
      expose :code
    end
  end
end
