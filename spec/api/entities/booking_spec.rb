require 'rails_helper'

RSpec.describe API::Entities::Booking do
  let(:currency) { FactoryBot.create(:currency) }
  let(:package) { FactoryBot.create(:package, delivery_daterange: (Date.today..7.days.after)) }
  let!(:package_pricing) { FactoryBot.create(:package_pricing, package: package, currency: currency) }
  let!(:package_item) { FactoryBot.create(:package_item, package: package) }

  let(:trip) { FactoryBot.create(:trip) }
  let!(:trip_pricing) { FactoryBot.create(:trip_pricing, trip: trip, currency: currency) }

  let(:booking) { FactoryBot.create(:booking, trip: trip, package: package, currency: currency) }
  let(:booking_entity) { API::Entities::Booking.represent(booking) }

  subject { JSON.parse(booking_entity.to_json) }

  it 'matches the api specification' do
    expect(subject).
      to eq(
        'id' => booking.id,
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
          'id' => package.destination.id,
          'name' => package.destination.name,
          'code' => package.destination.code,
          'city' => {
            'id' => package.destination.city.id,
            'name' => package.destination.city.name,
            'country' => {
              'id' => package.destination.city.country.id,
              'name' => package.destination.city.country.name,
              'code' => package.destination.city.country.code,
            },
          },
        },
        'departure' => {
          'id' => package.departure.id,
          'name' => package.departure.name,
          'code' => package.departure.code,
          'city' => {
            'id' => package.departure.city.id,
            'name' => package.departure.city.name,
            'country' => {
              'id' => package.departure.city.country.id,
              'name' => package.departure.city.country.name,
              'code' => package.departure.city.country.code,
            },
          },
        },
        'delivery_date_lower_bound' => package.delivery_daterange.first.iso8601,
        'delivery_date_upper_bound' => package.delivery_daterange.last.iso8601,
        'dispatcher' => {
          'id' => package.dispatcher.id,
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
        },
        'dispatcher' => {
          'id' => booking.dispatcher.id,
          'name' => booking.dispatcher.name,
          'email' => booking.dispatcher.email,
        },
        'transporter' => {
          'id' => booking.transporter.id,
          'name' => booking.transporter.name,
          'email' => booking.transporter.email,
        }
      )
  end
end
