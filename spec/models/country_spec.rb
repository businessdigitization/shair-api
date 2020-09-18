require 'rails_helper'

RSpec.describe Country do
  subject { FactoryBot.create(:country) }

  it 'has a valid factory' do
    factory = FactoryBot.build(:country)
    expect(factory).to be_valid
  end

  describe 'associations' do
    it { is_expected.to have_many(:cities).inverse_of(:country) }
    it { is_expected.to have_many(:airports).through(:cities) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:code) }
    it { is_expected.to validate_uniqueness_of(:code) }
    it { is_expected.to validate_presence_of(:name) }

    describe 'format of code' do
      it { is_expected.to allow_value('AG').for(:code) }

      it { is_expected.not_to allow_value('abc').for(:code) }
      it { is_expected.not_to allow_value("*&^").for(:code) }
      it { is_expected.not_to allow_value('123').for(:code) }
      it { is_expected.not_to allow_value('GGH').for(:code) }
    end
  end
end
