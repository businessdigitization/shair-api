require 'rails_helper'

RSpec.describe PackagePricing, type: :model do
  describe 'validation' do
    it { is_expected.to validate_presence_of(:price) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:package).inverse_of(:pricing) }
    it { is_expected.to belong_to(:currency) }
  end
end
