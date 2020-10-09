class SearchTrip
  attr_reader :origin_airport_code, :destination_airport_code

  def self.call(params)
    new(params).call
  end

  def initialize(params)
    params = params
    @origin_airport_code = params[:origin_airport_code]
    @destination_airport_code = params[:destination_airport_code]
  end

  def call
    Trip.where(origin_airport_code: origin_airport_code,
               destination_airport_code: destination_airport_code)
  end
end
