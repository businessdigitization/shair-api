module API
  module Entities
    class Country < API::Entities::Base
      expose :name
      expose :code
    end
  end
end
