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
      Trip.create!(attribute_hash)
    end
  end
end
