require 'rails_helper'

RSpec.describe Route do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:from) }
    it { is_expected.to validate_presence_of(:to) }
    it { is_expected.to validate_presence_of(:route_type) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:trips) }
  end

  describe '#route_type' do
    it 'defines enum' do
      is_expected.to define_enum_for(:route_type)
        .with_values({ flight: 0, train: 1, bus: 2, car: 3, ship: 4, mixed: 5, other: 6 })
    end
  end
end
