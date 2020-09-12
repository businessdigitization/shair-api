require 'rails_helper'

RSpec.describe PackageItem do
  describe 'validation' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:count) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:package).inverse_of(:items) }
  end
end
