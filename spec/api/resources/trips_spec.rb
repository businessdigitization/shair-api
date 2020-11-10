require 'rails_helper'
RSpec.describe Resources::Trips do
  let(:response_json) { JSON.parse(response.body) }

  describe 'POST /trips' do
    let(:request_url) { '/api/v1/trips' }
    let!(:destination) { FactoryBot.create(:airport, code: 'LHR') }
    let!(:origin) { FactoryBot.create(:airport, code: 'JFK') }
    let(:destination_city) { destination.city }
    let(:destination_country) { destination.city.country }
    let(:origin_city) { origin.city }
    let(:origin_country) { origin.city.country }
    let!(:transporter) { FactoryBot.create(:user, email: 'transporter@example.com') }
    let!(:currency) { FactoryBot.create(:currency, code: 'BDT') }

    let(:auth_header) { generate_auth_header(transporter) }

    let(:trip_params) do
      {
        destination_airport_code: 'LHR',
        origin_airport_code: 'JFK',
        transporter_email: 'transporter@example.com',
        status: 'draft',
        luggage_capacity: 20,
        preference: 'No food',
        departure_at: '2022-09-25',
        arrival_at: '2022-09-29',
        pricing: {
          unit_price: 5,
          minimum_price: 5,
          currency_code: 'BDT',
          negotiable: true
        }
      }
    end

    context 'invalid params' do
      let(:required_params) do
        [
          :destination_airport_code,
          :origin_airport_code,
          :transporter_email,
        ]
      end

      it 'responds with 422 status without required params' do
        required_params.each do |required_param|
          post request_url, params: trip_params.except(required_param), headers: auth_header
          expect(response.status).to eq(422)
        end
      end
    end

    context 'valid params' do
      let(:expected_result) do
        {
          'id' => Trip.last.id,
          'destination' => {
            'name' => destination.name,
            'code' => 'LHR',
            'city' => {
              'name' => destination_city.name,
              'country' => {
                'name' => destination_country.name,
                'code' => destination_country.code
              }
            }
          },
          'origin' => {
            'name' => origin.name,
            'code' => 'JFK',
            'city' => {
              'name' => origin_city.name,
              'country' => {
                'name' => origin_country.name,
                'code' => origin_country.code
              }
            }
          },
          'departure_at' => '2022-09-25T00:00:00Z',
          'arrival_at' => '2022-09-29T00:00:00Z',
          'transporter' => {
            'name' => 'Faruk Hossain',
            'email' => 'transporter@example.com'
          },
          'status' => 'draft',
          'luggage_capacity' => '20.0',
          'pricing' => {
            'id' => Trip.last.pricing.id,
            'unit_price' => 5.0,
            'minimum_price' => 5.0,
            'currency' => {
              'name' => 'Bangladeshi Taka',
              'code' => 'BDT'
            },
            'negotiable' => true
          }, 'preference' => 'No food'
        }
      end

      it 'returns a response of application/json type' do
        post request_url, params: trip_params, headers: auth_header

        expect(response.content_type).to eq('application/json')
      end

      it 'returns results with respond code 201' do
        post request_url, params: trip_params, headers: auth_header
        expect(response.status).to eq(201)
      end

      it 'returns expected result' do
        post request_url, params: trip_params, headers: auth_header
        expect(response_json).to eq(expected_result)
      end
    end
  end

  describe 'PATCH /trips/:id' do
    let!(:trip) { FactoryBot.create(:trip) }
    let!(:trip_pricing) { FactoryBot.create(:trip_pricing, trip: trip) }
    let(:request_url) { "/api/v1/trips/#{trip.id}" }
    let(:auth_header) { generate_auth_header(trip.transporter) }

    context 'invalid params' do
      let(:request_url) { '/api/v1/trips/1234' }

      it 'responds with 404' do
        patch request_url, params: {}, headers: auth_header
        expect(response.status).to eq(404)
      end
    end

    context 'valid params' do
      let!(:origin) { FactoryBot.create(:airport, code: 'DEL') }
      let!(:destination) { FactoryBot.create(:airport, code: 'KOL') }
      let!(:currency) { FactoryBot.create(:currency, code: 'NRP') }

      let(:trip_params) do
        {
          destination_airport_code: 'DEL',
          origin_airport_code: 'KOL',
          status: 'published',
          luggage_capacity: 17,
          preference: 'No Animal',
          departure_at: '2023-09-25',
          arrival_at: '2024-09-29',
          pricing: {
            id: trip_pricing.id,
            unit_price: 4,
            minimum_price: 3,
            currency_code: 'NRP',
            negotiable: false
          }
        }
      end

      it 'returns a response of application/json type' do
        patch request_url, params: trip_params, headers: auth_header
        expect(response.content_type).to eq('application/json')
      end

      it 'returns results with respond code 200' do
        patch request_url, params: trip_params, headers: auth_header
        expect(response.status).to eq(200)
      end

      it 'return results as an hash' do
        patch request_url, params: trip_params, headers: auth_header
        expect(response_json).to be_instance_of(Hash)
      end

      it 'updates trip and pricing attributes' do
        patch request_url, params: trip_params, headers: auth_header

        trip.reload

        expect(trip.origin_airport_code).to eq('KOL')
        expect(trip.destination_airport_code).to eq('DEL')
        expect(trip.status).to eq('published')
        expect(trip.luggage_capacity).to eq(17)
        expect(trip.preference).to eq('No Animal')
        expect(trip.departure_at).to eq('2023-09-25')
        expect(trip.arrival_at).to eq('2024-09-29')

        expect(trip.pricing.unit_price).to eq(4)
        expect(trip.pricing.minimum_price).to eq(3)
        expect(trip.pricing.currency_code).to eq('NRP')
        expect(trip.pricing.negotiable).to eq(false)
      end
    end
  end

  describe 'GET /trips/:id' do
    context 'invalid params' do
      let(:request_url) { '/api/v1/trips/1234' }

      it 'responds with 404' do
        get request_url, params: {}
        expect(response.status).to eq(404)
      end
    end

    context 'valid params' do
      let(:trip) { FactoryBot.create(:trip) }
      let(:request_url) { "/api/v1/trips/#{trip.id}" }

      it 'returns a response of application/json type' do
        get request_url
        expect(response.content_type).to eq('application/json')
      end

      it 'returns results with respond code 200' do
        get request_url
        expect(response.status).to eq(200)
      end

      it 'return results as an hash' do
        get request_url
        expect(response_json).to be_instance_of(Hash)
      end
    end
  end

  describe 'DELETE /trips/:id' do
    context 'invalid params' do
      let(:request_url) { '/api/v1/trips/1234' }
      let(:auth_header) { generate_auth_header }

      it 'responds with 404' do
        delete request_url, params: {}, headers: auth_header
        expect(response.status).to eq(404)
      end
    end

    context 'valid params' do
      let(:trip) { FactoryBot.create(:trip) }
      let(:request_url) { "/api/v1/trips/#{trip.id}" }
      let(:auth_header) { generate_auth_header(trip.transporter) }

      it 'does not return a body' do
        delete request_url, headers: auth_header
        expect(response.content_type).to be_nil
      end

      it 'returns results with respond code 204' do
        delete request_url, headers: auth_header
        expect(response.status).to eq(204)
      end

      it 'return results as an hash' do
        get request_url , headers: auth_header
        expect(response_json).to be_instance_of(Hash)
      end
    end
  end

  describe 'GET /trips/search' do
    let(:request_url) { '/api/v1/trips/search/' }

    let(:airport_a) { FactoryBot.create(:airport, code: 'DAC') }
    let(:airport_b) { FactoryBot.create(:airport, code: 'DAD',) }
    let!(:trip) { FactoryBot.create(:trip, origin: airport_a, destination: airport_b) }

    context 'invalid params' do
      it 'responds with 422 status without required params' do
        get request_url
        expect(response.status).to eq(422)
      end
    end

    context 'valid params' do
      let(:query_params) do
        {
          origin_airport_code: 'DAC',
          destination_airport_code: 'DAD'
        }
      end

      it 'returns a response of application/json type' do
        get request_url, params: query_params
        expect(response.content_type).to eq('application/json')
      end

      it 'returns results with respond code 200' do
        get request_url, params: query_params
        expect(response.status).to eq(200)
      end

      it 'return results as an array' do
        get request_url, params: query_params
        expect(response_json).to be_instance_of(Array)
      end
    end
  end
end
