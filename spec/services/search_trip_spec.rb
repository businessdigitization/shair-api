require 'rails_helper'
RSpec.describe SearchTrip do
  let(:airport_a) { FactoryBot.create(:airport, code: 'DAC') }
  let(:airport_b) { FactoryBot.create(:airport, code: 'DAD') }
  let(:airport_c) { FactoryBot.create(:airport, code: 'NTX')}
  let!(:a_to_b) { FactoryBot.create(:trip, origin: airport_a, destination: airport_b) }
  let!(:b_to_a) { FactoryBot.create(:trip, origin: airport_b, destination: airport_a) }
  let!(:another_trip) { FactoryBot.create(:trip, origin: airport_a, destination: airport_b) }

  subject { described_class.call(params) }

  describe '.call' do
    context 'query does not matche with any trip' do
      let(:params) do
        {
          origin_airport_code: 'DAC',
          destination_airport_code: 'NTX'
        }
      end

      specify { expect(subject).to match_array([])}
    end

    context 'query matches with ongoing trips' do
      let(:params) do
        {
          origin_airport_code: 'DAC',
          destination_airport_code: 'DAD'
        }
      end

      it 'returns all matching trips' do
        expect(subject).to match_array([a_to_b, another_trip])
      end
    end
  end
end
