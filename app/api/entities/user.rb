module Entities
  class User < API::Entities::Base
    expose :name
    expose :email
  end
end
