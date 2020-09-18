require 'rails_helper'

RSpec.describe PackagePricing do
  it 'has a valid factory' do
    factory = FactoryBot.build(:package_pricing)
    expect(factory).to be_valid
  end

  describe 'associations' do
    it { is_expected.to belong_to(:package).inverse_of(:pricing) }
    it { is_expected.to belong_to(:currency) }
  end
  
  describe 'validation' do
    it { is_expected.to validate_presence_of(:price) }
  end
end
