require 'rails_helper'

RSpec.describe Trip do
  describe 'validation' do
    it { is_expected.to validate_presence_of(:status) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end

  describe '#status' do
    it 'defines enum' do
      is_expected.to define_enum_for(:status)
        .with_values({ draft: 0, published: 1, booked: 3, in_progress: 4, complete: 5, outdated: 6 })
    end
  end
end
