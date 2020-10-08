require 'rails_helper'
RSpec.describe Resources::Airports do
  let(:response_json) { JSON.parse(response.body) }

  describe 'GET /airports/search' do
    let(:request_url) { '/api/v1/airports/search/' }
    let!(:airport) { FactoryBot.create(:airport, code: 'LHR') }

    context 'invalid params' do
      it 'responds with 422 status without required params' do
        get request_url
        expect(response.status).to eq(422)
      end
    end

    context 'valid params' do
      let(:query_params) do
        {
          query: 'LHR'
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
