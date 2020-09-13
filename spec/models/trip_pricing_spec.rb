require 'rails_helper'

RSpec.describe TripPricing do
  describe 'validation' do
    it { is_expected.to validate_presence_of(:unit_price) }
    it { is_expected.to validate_presence_of(:minimum_price) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:trip).inverse_of(:pricing) }
    it { is_expected.to belong_to(:currency) }
  end
end
