require 'rails_helper'
RSpec.describe Resources::Packages do
  let(:response_json) { JSON.parse(response.body) }

  describe 'POST /packages' do
    let(:request_url) { '/api/v1/packages' }
    let!(:destination) { FactoryBot.create(:airport, code: 'LHR') }
    let!(:origin) { FactoryBot.create(:airport, code: 'JFK') }
    let(:destination_city) { destination.city }
    let(:destination_country) { destination.city.country }
    let(:origin_city) { origin.city }
    let(:origin_country) { origin.city.country }
    let!(:dispatcher) { FactoryBot.create(:user, email: 'dispatcher@example.com') }
    let!(:currency) { FactoryBot.create(:currency, code: 'BDT') }

    let(:package_params) do
      {
        origin_airport_code: 'JFK',
        destination_airport_code: 'LHR',
        dispatcher_email: 'dispatcher@example.com',
        status: 'draft',
        weight: 4.3,
        description: 'Jhola',
        preference: 'hello there',
        pricing: {
          price: 5,
          currency_code: 'BDT',
          negotiable: true
        },
        items: [
          {
            count: 1,
            name: 'Ball',
            description: 'Cricket Ball'
          },
          {
            count: 10,
            name: 'Mobile',
            description: 'Samsung'
          }
        ]
      }
    end

    context 'valid params' do
      let(:expected_result) do
        {
          'id' => Package.last.id,
          'destination' => {
            'name' => destination.name,
            'code' => 'LHR',
            'city' => {
              'name' => destination_city.name,
              'country' => {
                'name' => destination_country.name,
                'code' => destination_country.code,
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
                'code' => origin_country.code,
              }
            }
          },
          'dispatcher' => {
            'name' => 'Faruk Hossain',
            'email' => 'dispatcher@example.com',
          },
          'status' => 'draft',
          'description' => 'Jhola',
          'weight' => 4.3,
          'items' => [{
            'id' => PackageItem.find_by(name: 'Ball').id,
            'name' => 'Ball',
            'description' => 'Cricket Ball',
            'count' => 1,
          },
          {
            'id' => PackageItem.find_by(name: 'Mobile').id,
            'name' => 'Mobile',
            'description' => 'Samsung',
            'count' => 10,
          }],
          'pricing' => {
            'id' => PackagePricing.last.id,
            'price' => 5.0,
            'currency' => {
              'name' => 'Bangladeshi Taka',
              'code' => 'BDT',
            },
            'negotiable' => true,
          },
          'preference' => 'hello there',
        }
      end

      it 'returns a response of application/json type' do
        post request_url, params: package_params
        expect(response.content_type).to eq('application/json')
      end

      it 'returns results with respond code 201' do
        post request_url, params: package_params
        expect(response.status).to eq(201)
      end

      it 'returns expected result' do
        post request_url, params: package_params
        expect(response_json).to eq(expected_result)
      end
    end
  end

  describe 'PATCH /packages/:id' do
    let!(:package) { FactoryBot.create(:package) }
    let!(:package_pricing) { FactoryBot.create(:package_pricing, package: package) }
    let!(:package_item) { FactoryBot.create(:package_item, name: 'Paper Book', package: package) }
    let(:request_url) { "/api/v1/packages/#{package.id}" }

    context 'invalid params' do
      let(:request_url) { '/api/v1/packages/1234' }

      it 'responds with 404' do
        patch request_url, params: {}
        expect(response.status).to eq(404)
      end
    end

    context 'valid params' do
      let!(:origin) { FactoryBot.create(:airport, code: 'DEL') }
      let!(:destination) { FactoryBot.create(:airport, code: 'KOL') }
      let!(:currency) { FactoryBot.create(:currency, code: 'NRP') }

      let(:package_params) do
        {
          destination_airport_code: 'DEL',
          origin_airport_code: 'KOL',
          preference: 'No Animal',
          status: 'published',
          pricing: {
            id: package_pricing.id,
            price: 4,
          },
          items: [{
            id: package_item.id,
            name: 'Box',
          }]
        }
      end

      let(:create_items_params) do
        {
          new_items: [
            {
              name: 'Toy',
              count: 3
            }
          ]
        }
      end

      let(:delete_items_params) do
        {
          items: [
            {
              id: package_item.id,
              _destroy: true,
            }
          ]
        }
      end

      it 'returns a response of application/json type' do
        patch request_url, params: package_params
        expect(response.content_type).to eq('application/json')
      end

      it 'returns results with respond code 200' do
        patch request_url, params: package_params
        expect(response.status).to eq(200)
      end

      it 'return results as an hash' do
        patch request_url, params: package_params
        expect(response_json).to be_instance_of(Hash)
      end

      it 'updates package, package items and pricing attributes' do
        patch request_url, params: package_params

        package.reload

        expect(package.origin_airport_code).to eq('KOL')
        expect(package.destination_airport_code).to eq('DEL')
        expect(package.preference).to eq('No Animal')
        expect(package.status).to eq('published')

        expect(package_pricing.reload.price).to eq(4)

        expect(package_item.reload.name).to eq('Box')
      end

      it 'creates item' do
        expect { patch request_url, params: create_items_params }.
          to change {PackageItem.count}.by(1)

        expect(package.reload.items.last.name).to eq('Toy')
      end

      it 'deletes items' do
        expect { patch request_url, params: delete_items_params }.
          to change {PackageItem.count}.by(-1)
      end
    end
  end

  describe 'GET /packages/:id' do
    context 'invalid params' do
      let(:request_url) { '/api/v1/packages/1234' }

      it 'responds with 404' do
        get request_url, params: {}
        expect(response.status).to eq(404)
      end
    end

    context 'valid params' do
      let(:package) { FactoryBot.create(:package) }
      let(:request_url) { "/api/v1/packages/#{package.id}" }

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

  describe 'DELETE /packages/:id' do
    context 'invalid params' do
      let(:request_url) { '/api/v1/packages/1234' }

      it 'responds with 404' do
        delete request_url, params: {}
        expect(response.status).to eq(404)
      end
    end

    context 'valid params' do
      let(:package) { FactoryBot.create(:package) }
      let(:request_url) { "/api/v1/packages/#{package.id}" }

      it 'does not return a body' do
        delete request_url
        expect(response.content_type).to be_nil
      end

      it 'returns results with respond code 204' do
        delete request_url
        expect(response.status).to eq(204)
      end

      it 'return results as an hash' do
        get request_url
        expect(response_json).to be_instance_of(Hash)
      end
    end
  end

  describe 'GET /packages/search' do
    let(:request_url) { '/api/v1/packages/search/' }

    let(:airport_a) { FactoryBot.create(:airport, code: 'DAC') }
    let(:airport_b) { FactoryBot.create(:airport, code: 'DAD',) }
    let!(:package) { FactoryBot.create(:package, origin: airport_a, destination: airport_b) }

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
