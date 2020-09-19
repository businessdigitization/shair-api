module API
  module Entities
    class PackagePricing < API::Entities::Base
      expose :id

      with_options(format_with: :float) do
        expose :price
      end

      expose :currency, with: API::Entities::Currency
      expose :negotiable
    end
  end
end
