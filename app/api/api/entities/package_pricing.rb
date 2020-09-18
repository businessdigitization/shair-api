module API
  module Entities
    class PackagePricing < API::Entities::Base
      expose :price
      expose :currency, with: API::Entities::Currency
      expose :negotiable
    end
  end
end
