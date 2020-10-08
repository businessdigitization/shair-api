require 'rails_helper'

RSpec.describe SearchAirport do
  let(:bangladesh) { FactoryBot.create(:country, name: 'Bangladesh') }
  let(:dhaka) { FactoryBot.create(:city, name: 'Dhaka', country: bangladesh) }
  let!(:saidpur) { FactoryBot.create(:city, name: 'Saidpur', country: bangladesh) }
  let!(:zia_airport) { FactoryBot.create(:airport, name: 'Zia Bondor', code: 'DAC', city: dhaka) }
  let!(:vasani_airport) { FactoryBot.create(:airport, name: 'Vashani Bimanbondor', code: 'DAD', city: dhaka) }
  let!(:saidpur_airport) { FactoryBot.create(:airport, name: 'Nilfamari Bimanbondor', code: 'NBD', city: saidpur) }

  subject { described_class.call(query) }

  describe '.call' do
    context 'query does not matche country name, city name, airport name or airport code' do
      let(:query) { 'nonsense' }

      specify { expect(subject).to match_array([])}
    end

    context 'query represents country name' do
      let(:query) { 'Bangladesh' }

      it 'returns all airport of matching country' do
        expect(subject).to match_array([saidpur_airport, zia_airport, vasani_airport])
      end
    end

    context 'query represents city name' do
      let(:query) { 'Dhaka' }

      it 'returns all airport of matching city' do
        expect(subject).to match_array([zia_airport, vasani_airport])
      end
    end

    context 'query represents airport name' do
      let(:query) { 'Zia Bondor' }

      it 'returns airport with exact airport code' do
        expect(subject).to match_array([zia_airport])
      end
    end

    context 'query represents airport code' do
      let(:query) { 'NBD' }

      it 'returns airports sharing same name(fully or patially)' do
        expect(subject).to match_array([saidpur_airport])
      end
    end
  end
end
