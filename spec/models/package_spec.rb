require 'rails_helper'

RSpec.describe Package do
  it 'has a valid factory' do
    factory = FactoryBot.build(:package)
    expect(factory).to be_valid
  end

  describe 'validation' do
    it { is_expected.to validate_presence_of(:status) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:transiter).inverse_of(:packages) }
    it { is_expected.to belong_to(:departure) }
    it { is_expected.to belong_to(:destination) }
    it { is_expected.to have_many(:items).dependent(:destroy) }
    it { is_expected.to have_many(:bookings) }
    it { is_expected.to have_one(:pricing).dependent(:destroy) }
  end
end
