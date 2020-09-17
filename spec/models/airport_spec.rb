require 'rails_helper'

RSpec.describe Airport do
  subject { FactoryBot.create(:airport) }

  it 'has a valid factory' do
    factory = FactoryBot.build(:airport)
    expect(factory).to be_valid
  end

  describe 'associations' do
    it { is_expected.to belong_to(:city).inverse_of(:airports) }
    it { is_expected.to have_many(:incoming_packages) }
    it { is_expected.to have_many(:outgoing_packages) }
    it { is_expected.to have_many(:incoming_trips) }
    it { is_expected.to have_many(:incoming_trips) }
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
end
