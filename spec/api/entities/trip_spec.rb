require 'rails_helper'

RSpec.describe Entities::Trip do
  let(:trip) { FactoryBot.create(:trip) }
  let!(:trip_pricing) { FactoryBot.create(:trip_pricing, trip: trip) }
  let(:trip_entity) { Entities::Trip.represent(trip) }

  subject { JSON.parse(trip_entity.to_json) }

  it 'matches the api specification' do
    expect(subject)
      .to eq(
        'id' => trip.id,
        'destination' => {
          'name' => trip.destination.name,
          'code' => trip.destination.code,
          'city' => {
            'name' => trip.destination.city.name,
            'country' => {
              'name' => trip.destination.city.country.name,
              'code' => trip.destination.city.country.code,
            },
          },
        },
        'origin' => {
          'name' => trip.origin.name,
          'code' => trip.origin.code,
          'city' => {
            'name' => trip.origin.city.name,
            'country' => {
              'name' => trip.origin.city.country.name,
              'code' => trip.origin.city.country.code,
            },
          },
        },
        'departure_at' => trip.departure_at.iso8601,
        'arrival_at' => trip.arrival_at.iso8601,
        'transporter' => {
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
