require 'rails_helper'

RSpec.describe Place do
  describe 'validation' do
    it { is_expected.to validate_presence_of(:name) }
  end
end
