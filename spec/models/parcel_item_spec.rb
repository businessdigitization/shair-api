require 'rails_helper'

RSpec.describe ParcelItem do
  it 'has a valid factory' do
    factory = FactoryBot.build(:parcel_item)
    expect(factory).to be_valid
  end

  describe 'associations' do
    it { is_expected.to belong_to(:parcel).inverse_of(:items) }
    it { is_expected.to belong_to(:item_type) }
  end

  describe 'validation' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:count) }
  end
end
