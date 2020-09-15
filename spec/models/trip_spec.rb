require 'rails_helper'

RSpec.describe Trip do
  it 'has a valid factory' do
    factory = FactoryBot.build(:trip)
    expect(factory).to be_valid
  end

  describe 'validation' do
    it { is_expected.to validate_presence_of(:status) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:transporter).inverse_of(:trips) }
    it { is_expected.to belong_to(:departure) }
    it { is_expected.to belong_to(:destination) }
    it { is_expected.to have_one(:pricing).dependent(:destroy) }
    it { is_expected.to have_many(:bookings) }
  end
end
