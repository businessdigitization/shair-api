require 'rails_helper'

RSpec.describe TripPricing do
  it 'has a valid factory' do
    factory = FactoryBot.build(:trip_pricing)
    expect(factory).to be_valid
  end

  describe 'validation' do
    it { is_expected.to validate_presence_of(:unit_price) }
    it { is_expected.to validate_presence_of(:minimum_price) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:trip).inverse_of(:pricing) }
    it { is_expected.to belong_to(:currency) }
  end
end
