module TripService
  class Update
    include AttributeHelper
    attr_reader :params

    def self.call(params)
      new(params).call
    end

    def initialize(params)
      @params = params
    end

    def call
      trip.update!(trip_attributes)
      trip
    end

    private

    def trip
      Trip.find(params[:id])
    end
  end
end
