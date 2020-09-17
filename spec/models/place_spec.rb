require 'rails_helper'

RSpec.describe Place do
  it 'has a valid factory' do
    factory = FactoryBot.build(:place)
    expect(factory).to be_valid
  end

  describe 'validation' do
    it { is_expected.to validate_presence_of(:name) }
  end
end
