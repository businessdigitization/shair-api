require 'rails_helper'

RSpec.describe API::Entities::Trip do
  let(:trip) { FactoryBot.create(:trip) }
  let!(:trip_pricing) { FactoryBot.create(:trip_pricing, trip: trip) }
  let(:trip_entity) { API::Entities::Trip.represent(trip) }

  subject { JSON.parse(trip_entity.to_json) }

  it 'matches the api specification' do
    expect(subject)
      .to eq(
        'id' => trip.id,
        'destination' => {
          'id' => trip.destination.id,
          'name' => trip.destination.name,
          'code' => trip.destination.code,
          'city' => {
            'id' => trip.destination.city.id,
            'name' => trip.destination.city.name,
            'country' => {
              'id' => trip.destination.city.country.id,
              'name' => trip.destination.city.country.name,
              'code' => trip.destination.city.country.code,
            },
          },
        },
        'departure' => {
          'id' => trip.departure.id,
          'name' => trip.departure.name,
          'code' => trip.departure.code,
          'city' => {
            'id' => trip.departure.city.id,
            'name' => trip.departure.city.name,
            'country' => {
              'id' => trip.departure.city.country.id,
              'name' => trip.departure.city.country.name,
              'code' => trip.departure.city.country.code,
            },
          },
        },
        'departure_on' => trip.departure_on.iso8601,
        'departure_at' => trip.departure_at,
        'arrival_at' => trip.arrival_at,
        'transporter' => {
          'id' => trip.transporter.id,
          'name' => trip.transporter.name,
          'email' => trip.transporter.email,
        },
        'status' => trip.status,
        'luggage_capacity' => trip.luggage_capacity,
        'pricing' => {
          'id' => trip_pricing.id,
          'unit_price' => trip_pricing.unit_price,
          'minimum_price' => trip_pricing.minimum_price,
          'currency' => {
            'name' => trip_pricing.currency.name,
            'code' => trip_pricing.currency.code,
          },
          'negotiable' => trip_pricing.negotiable,
        },
        'preference' => trip.preference,
      )
  end
end
