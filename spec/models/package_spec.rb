require 'rails_helper'

RSpec.describe Package do
  describe 'validation' do
    it { is_expected.to validate_presence_of(:status) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:departure) }
    it { is_expected.to belong_to(:destination) }
  end

  describe '#status' do
    it 'defines enum' do
      is_expected.to define_enum_for(:status)
        .with_values({ draft: 0, published: 1, outdated: 2 })
    end
  end
end
