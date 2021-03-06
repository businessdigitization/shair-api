require 'rails_helper'

RSpec.describe Airport do
  let(:country) { FactoryBot.create(:country, name: 'Lala Land', code: 'LL') }
  let(:city) { FactoryBot.create(:city, name: 'Lulu', country: country) }

  subject { FactoryBot.create(:airport, name: 'Lala Airport', code: 'LUL', city: city) }

  it 'has a valid factory' do
    factory = FactoryBot.build(:airport)
    expect(factory).to be_valid
  end

  describe 'associations' do
    it { is_expected.to belong_to(:city).inverse_of(:airports) }
    it { is_expected.to have_many(:incoming_parcels).inverse_of(:destination) }
    it { is_expected.to have_many(:outgoing_parcels).inverse_of(:origin) }
    it { is_expected.to have_many(:incoming_trips).inverse_of(:destination) }
    it { is_expected.to have_many(:outgoing_trips).inverse_of(:origin) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:code) }
    it { is_expected.to validate_uniqueness_of(:code) }
    it { is_expected.to validate_presence_of(:name) }

    describe 'format of code' do
      it { is_expected.to allow_value('AGG').for(:code) }
      it { is_expected.not_to allow_value('abc').for(:code) }
      it { is_expected.not_to allow_value("*&^").for(:code) }
      it { is_expected.not_to allow_value('123').for(:code) }
      it { is_expected.not_to allow_value('AGGH').for(:code) }
    end
  end

  describe '.to_s' do
    specify { expect(subject.to_s).to eq('Lulu, Lala Land, LUL') }
  end
end
