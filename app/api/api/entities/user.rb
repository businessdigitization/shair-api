module API
  module Entities
    class User < API::Entities::Base
      expose :id
      expose :name
      expose :email
    end
  end
end
