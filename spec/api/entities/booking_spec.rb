require 'rails_helper'

RSpec.describe Entities::Booking do
  let(:currency) { FactoryBot.create(:currency) }
  let(:parcel) { FactoryBot.create(:parcel) }
  let!(:parcel_pricing) { FactoryBot.create(:parcel_pricing, parcel: parcel, currency: currency) }
  let!(:parcel_item) { FactoryBot.create(:parcel_item, parcel: parcel) }

  let(:trip) { FactoryBot.create(:trip) }
  let!(:trip_pricing) { FactoryBot.create(:trip_pricing, trip: trip, currency: currency) }

  let(:booking) { FactoryBot.create(:booking, trip: trip, parcel: parcel, currency: currency) }
  let(:booking_entity) { Entities::Booking.represent(booking) }

  subject { JSON.parse(booking_entity.to_json) }

  it 'matches the api specification' do
    expect(subject)
      .to eq(
        'number' => booking.number,
        'status' => booking.status,
        'price' => booking.price,
        'dispatcher_proposed_price' => booking.dispatcher_proposed_price,
        'transporter_proposed_price' => booking.transporter_proposed_price,
        'currency' => {
          'name' => currency.name,
          'code' => currency.code,
        },
        'parcel' => {
          'id' => parcel.id,
          'destination' => {
            'name' => parcel.destination.name,
            'code' => parcel.destination.code,
            'city' => {
              'name' => parcel.destination.city.name,
              'country' => {
                'name' => parcel.destination.city.country.name,
                'code' => parcel.destination.city.country.code,
              },
            },
          },
          'origin' => {
            'name' => parcel.origin.name,
            'code' => parcel.origin.code,
            'city' => {
              'name' => parcel.origin.city.name,
              'country' => {
                'name' => parcel.origin.city.country.name,
                'code' => parcel.origin.city.country.code,
              },
            },
          },
          'dispatcher' => {
            'name' => parcel.dispatcher.name,
            'email' => parcel.dispatcher.email,
          },
          'status' => parcel.status,
          'description' => parcel.description,
          'weight' => parcel.weight,
          'items' => [
            {
              'id' => parcel_item.id,
              'name' => parcel_item.name,
              'description' => parcel_item.description,
              'count' => parcel_item.count,
            }
          ],
          'pricing' => {
            'id' => parcel_pricing.id,
            'price' => parcel_pricing.price,
            'currency' => {
              'name' => parcel_pricing.currency.name,
              'code' => parcel_pricing.currency.code,
            },
            'negotiable' => parcel_pricing.negotiable,
          },
          'preference' => parcel.preference,
        },
        'trip' => {
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
        },
        'dispatcher' => {
          'name' => booking.dispatcher.name,
          'email' => booking.dispatcher.email,
        },
        'transporter' => {
          'name' => booking.transporter.name,
          'email' => booking.transporter.email,
        }
      )
  end
end
