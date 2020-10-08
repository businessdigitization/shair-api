module Entities
  class Package < API::Entities::Base
    expose :id
    expose :destination, with: API::Entities::Airport
    expose :origin, with: API::Entities::Airport

    with_options(format_with: :iso_date) do
      expose :delivery_date_lower_bound
      expose :delivery_date_upper_bound
    end

    expose :dispatcher, with: API::Entities::User
    expose :status
    expose :description

    with_options(format_with: :float) do
      expose :weight
    end

    expose :items, with: API::Entities::PackageItem
    expose :pricing, with: API::Entities::PackagePricing
    expose :preference

    def delivery_date_lower_bound
      object.delivery_daterange.first
    end

    def delivery_date_upper_bound
      object.delivery_daterange.last
    end
  end
end
