module Entities
  class ParcelPricing < Entities::Base
    expose :id

    with_options(format_with: :float) do
      expose :price
    end

    expose :currency, with: Entities::Currency
    expose :negotiable
  end
end
