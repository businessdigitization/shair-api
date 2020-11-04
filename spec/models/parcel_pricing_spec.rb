require 'rails_helper'

RSpec.describe ParcelPricing do
  it 'has a valid factory' do
    factory = FactoryBot.build(:parcel_pricing)
    expect(factory).to be_valid
  end

  describe 'associations' do
    it { is_expected.to belong_to(:parcel).inverse_of(:pricing) }
    it { is_expected.to belong_to(:currency) }
  end

  describe 'validation' do
    it { is_expected.to validate_presence_of(:price) }
  end
end
