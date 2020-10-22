require 'rails_helper'

RSpec.describe Entities::Booking do
  let(:currency) { FactoryBot.create(:currency) }
  let(:package) { FactoryBot.create(:package) }
  let!(:package_pricing) { FactoryBot.create(:package_pricing, package: package, currency: currency) }
  let!(:package_item) { FactoryBot.create(:package_item, package: package) }

  let(:trip) { FactoryBot.create(:trip) }
  let!(:trip_pricing) { FactoryBot.create(:trip_pricing, trip: trip, currency: currency) }

  let(:booking) { FactoryBot.create(:booking, trip: trip, package: package, currency: currency) }
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
        'package' => {
          'id' => package.id,
          'destination' => {
            'name' => package.destination.name,
            'code' => package.destination.code,
            'city' => {
              'name' => package.destination.city.name,
              'country' => {
                'name' => package.destination.city.country.name,
                'code' => package.destination.city.country.code,
              },
            },
          },
          'origin' => {
            'name' => package.origin.name,
            'code' => package.origin.code,
            'city' => {
              'name' => package.origin.city.name,
              'country' => {
                'name' => package.origin.city.country.name,
                'code' => package.origin.city.country.code,
              },
            },
          },
          'dispatcher' => {
            'name' => package.dispatcher.name,
            'email' => package.dispatcher.email,
          },
          'status' => package.status,
          'description' => package.description,
          'weight' => package.weight,
          'items' => [
            {
              'id' => package_item.id,
              'name' => package_item.name,
              'description' => package_item.description,
              'count' => package_item.count,
            }
          ],
          'pricing' => {
            'id' => package_pricing.id,
            'price' => package_pricing.price,
            'currency' => {
              'name' => package_pricing.currency.name,
              'code' => package_pricing.currency.code,
            },
            'negotiable' => package_pricing.negotiable,
          },
          'preference' => package.preference,
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
