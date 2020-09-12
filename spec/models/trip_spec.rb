require 'rails_helper'

RSpec.describe Trip do
  describe 'validation' do
    it { is_expected.to validate_presence_of(:status) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:departure) }
    it { is_expected.to belong_to(:destination) }
    it { is_expected.to have_one(:trip_pricing) }
  end
end
