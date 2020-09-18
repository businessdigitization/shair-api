require 'rails_helper'

RSpec.describe PackageItem do
  it 'has a valid factory' do
    factory = FactoryBot.build(:package_item)
    expect(factory).to be_valid
  end

  describe 'associations' do
    it { is_expected.to belong_to(:package).inverse_of(:items) }
  end

  describe 'validation' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:count) }
  end
end
