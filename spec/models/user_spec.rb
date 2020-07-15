require 'rails_helper'

RSpec.describe User do
  describe 'validations' do
    let(:user) { FactoryBot.build(:user, name: 'Faruk', email: 'faruk@gmail.com') }

    it 'is not valid without name' do
      user.name = nil
      expect(user.valid?).to eq(false)
    end

    it 'is not valid without email' do
      user.email = nil
      expect(user.valid?).to eq(false)
    end

    describe 'email validation' do
      it { is_expected.to allow_value('test@test.com').for(:email) }
      it { is_expected.not_to allow_value('invalidemailcom').for(:email) }
      it { is_expected.not_to allow_value('test @test.com').for(:email) }
      it { is_expected.not_to allow_value('tést@test.com').for(:email) }
      it { is_expected.not_to allow_value('däni@test.com').for(:email) }
      it { is_expected.not_to allow_value('test@test').for(:email) }
    end
  end

  describe 'associations' do
    it { is_expected.to have_many(:trips) }
  end

end
