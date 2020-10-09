module Entities
  class Package < Entities::Base
    expose :id
    expose :destination, with: Entities::Airport
    expose :origin, with: Entities::Airport

    with_options(format_with: :iso_date) do
      expose :delivery_date_lower_bound
      expose :delivery_date_upper_bound
    end

    expose :dispatcher, with: Entities::User
    expose :status
    expose :description

    with_options(format_with: :float) do
      expose :weight
    end

    expose :items, with: Entities::PackageItem
    expose :pricing, with: Entities::PackagePricing
    expose :preference

    def delivery_date_lower_bound
      object.delivery_daterange.first
    end

    def delivery_date_upper_bound
      object.delivery_daterange.last
    end
  end
end
