require 'rails_helper'
RSpec.describe Resources::ParcelItemTypes do
  let(:response_json) { JSON.parse(response.body) }

  describe 'GET' do
    let(:request_url) { '/api/v1/parcel_item_types/' }
    let!(:parcel_item_type) { FactoryBot.create(:parcel_item_type) }

    it 'returns a response of application/json type' do
      get request_url
      expect(response.content_type).to eq('application/json')
    end

    it 'returns results with respond code 200' do
      get request_url
      expect(response.status).to eq(200)
    end

    it 'return results as an array' do
      get request_url
      expect(response_json).to be_instance_of(Array)
    end
  end
end
