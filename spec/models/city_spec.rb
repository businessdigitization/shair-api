require 'rails_helper'

RSpec.describe City do
  it 'has a valid factory' do
    factory = FactoryBot.build(:city)
    expect(factory).to be_valid
  end

  describe 'associations' do
    it { is_expected.to belong_to(:country).inverse_of(:cities) }
    it { is_expected.to have_many(:airports) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end
end
