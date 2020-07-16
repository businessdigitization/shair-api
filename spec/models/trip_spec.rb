require 'rails_helper'

RSpec.describe Trip do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:route).optional(true) }
    it { is_expected.to belong_to(:journey_date_range).optional(true) }
    it { is_expected.to belong_to(:journey_time_range).optional(true) }
  end

  describe '#status' do
    it 'defines enum' do
      is_expected.to define_enum_for(:status)
        .with_values({ planning: 0, planned: 1, outdated: 2 })
    end
  end
end
