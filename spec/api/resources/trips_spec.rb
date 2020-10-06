require 'rails_helper'
RSpec.describe Resources::Trips do
  let(:response_json) { JSON.parse(response.body) }
  let(:departure) { FactoryBot.create(:airport, code: 'DEL') }
  let(:destination) { FactoryBot.create(:airport, code: 'KOL')}
  let(:currency) { FactoryBot.create(:currency, code: 'NRP')}

  describe 'POST /trips' do
    let(:request_url) { '/api/v1/trips' }
    let!(:destination) { FactoryBot.create(:airport, code: 'LHR') }
    let!(:departure) { FactoryBot.create(:airport, code: 'JFK') }
    let(:destination_city) { destination.city }
    let(:destination_country) { destination.city.country }
    let(:departure_city) { departure.city }
    let(:departure_country) { departure.city.country }
    let!(:transporter) { FactoryBot.create(:user, email: 'transporter@example.com') }
    let!(:currency) { FactoryBot.create(:currency, code: 'BDT') }

    let(:trip_params) do
      {
        destination_airport_code: 'LHR',
        departure_airport_code: 'JFK',
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

    context 'incomplete parameters' do
      let(:required_params) do
        [
          :destination_airport_code,
          :departure_airport_code,
          :transporter_email,
        ]
      end

      it 'responds with 422 status without required params' do
        required_params.each do |required_param|
          post request_url, params: trip_params.except(required_param)
          expect(response.status).to eq(422)
        end
      end
    end

    context 'complete parameters' do
      let(:expected_result) do
        {
          "id" => Trip.last.id,
          "destination" => {
            "name" => destination.name,
            "code" => "LHR",
            "city" => {
              "name" => destination_city.name,
              "country" => {
                "name" => destination_country.name,
                "code" => destination_country.code
              }
            }
          },
          "departure" => {
            "name" => departure.name,
            "code" => "JFK",
            "city" => {
              "name" => departure_city.name,
              "country" => {
                "name" => departure_country.name,
                "code" => departure_country.code
              }
            }
          },
          "departure_at" => "2022-09-25T00:00:00Z",
          "arrival_at" => "2022-09-29T00:00:00Z",
          "transporter" => {
            "name" => "Faruk Hossain",
            "email" => "transporter@example.com"
          },
          "status" => "draft",
          "luggage_capacity" => "20.0",
          "pricing" => {
            "id" => Trip.last.pricing.id,
            "unit_price" => 5.0,
            "minimum_price" => 5.0,
            "currency" => {
              "name" => "Bangladeshi Taka",
              "code" => "BDT"
            },
            "negotiable" => true
          }, "preference" => "No food"
        }
      end

      it 'returns a response of application/json type' do
        post request_url, params: trip_params
        expect(response.content_type).to eq('application/json')
      end

      it 'returns results with respond code 201' do
        post request_url, params: trip_params
        expect(response.status).to eq(201)
      end

      it 'returns expected result' do
        post request_url, params: trip_params
        expect(response_json).to eq(expected_result)
      end
    end
  end

  describe 'PATCH /customers/:id' do
    let(:trip) { FactoryBot.create(:trip) }

    let(:request_url) { "/api/v1/customers/#{customer.id}" }


  end

end
