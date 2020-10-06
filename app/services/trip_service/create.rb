module TripService
  class Create
    include AttributeHelper
    attr_reader :params

    def self.call(params)
      new(params).call
    end

    def initialize(params)
      @params = params
    end

    def call
      trip_attributes[:trip_attributes] = pricing_attributes if pricing_attributes
      Trip.create!(trip_attributes)
    end

    private

    def transporter
      User.find_by(email: params[:transporter_email])
    end
  end
end
