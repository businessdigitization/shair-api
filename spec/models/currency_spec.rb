require 'rails_helper'

RSpec.describe Currency do
  subject { FactoryBot.create(:currency) }

  it 'has a valid factory' do
    factory = FactoryBot.build(:currency)
    expect(factory).to be_valid
  end

  describe 'validation' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:code) }
    it { is_expected.to validate_uniqueness_of(:code) }

    describe 'format of code' do
      it { is_expected.to allow_value('AGG').for(:code) }
      it { is_expected.not_to allow_value('abc').for(:code) }
      it { is_expected.not_to allow_value("*&^").for(:code) }
      it { is_expected.not_to allow_value('123').for(:code) }
      it { is_expected.not_to allow_value('AGGH').for(:code) }
    end
  end
end
