require 'rails_helper'

RSpec.describe Country do
  let!(:country) { FactoryBot.create(:country) }

  it 'has a valid factory' do
    factory = FactoryBot.build(:country)
    expect(factory).to be_valid
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:code) }
    it { is_expected.to validate_uniqueness_of(:code) }
    it { is_expected.to validate_presence_of(:name) }
  end
end
