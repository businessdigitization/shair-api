class TripCreateService
  attr_reader :params

  def self.call(params)
    new(params).call
  end

  def initialize(params)
    @params = params
  end

  def call
    Trip.create!(trip_attributes)
  end

  private

  def trip_attributes
    {
      departure: departure,
      destination: destination,
      transporter: transporter,
      departure_at: params[:departure_at],
      arrival_at: params[:arrival_at],
      luggage_capacity: params[:luggage_capacity],
      preference: params[:preference],
      pricing_attributes: pricing_attributes
    }
  end

  def departure
    Airport.find_by(code: params[:departure_airport_code])
  end

  def destination
    Airport.find_by(code: params[:destination_airport_code])
  end

  def transporter
    User.find_by(email: params[:transporter_email])
  end

  def pricing_attributes
    {
      unit_price: params[:pricing][:unit_price],
      minimum_price: params[:pricing][:minimum_price],
      currency: Currency.find_by(code: params[:pricing][:currency_code]),
      negotiable: params[:pricing][:negotiable]
    }
  end
end
