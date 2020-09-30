module TripService
  module AttributeHelper
    def attribute_hash
      raw_attribute_hash = {
        departure: departure,
        destination: destination,
        transporter: transporter,
        departure_at: params[:departure_at],
        arrival_at: params[:arrival_at],
        luggage_capacity: params[:luggage_capacity],
        preference: params[:preference],
        pricing_attributes: pricing_attributes
      }

      return {} if raw_attribute_hash.blank?
      raw_attribute_hash.delete_if { |k, v| v.blank? }
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
      return unless params[:pricing]

      {
        unit_price: params[:pricing][:unit_price],
        minimum_price: params[:pricing][:minimum_price],
        currency: Currency.find_by(code: params[:pricing][:currency_code]),
        negotiable: params[:pricing][:negotiable]
      }
    end
  end
end
