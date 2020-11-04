require 'rails_helper'

RSpec.describe ParcelItemType do
  it 'has a valid factory' do
    factory = FactoryBot.build(:parcel_item)
    expect(factory).to be_valid
  end

  describe 'validation' do
    it { is_expected.to validate_presence_of(:name) }
  end
end
