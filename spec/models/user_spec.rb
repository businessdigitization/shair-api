require 'rails_helper'

RSpec.describe User do
  it 'has a valid factory' do
    factory = FactoryBot.build(:user)
    expect(factory).to be_valid
  end

  describe 'validations' do
    let!(:user) { FactoryBot.create(:user, name: 'Faruk', email: 'faruk@gmail.com') }

    it 'is not valid without name' do
      user.name = nil
      expect(user).to be_invalid
    end

    it 'is not valid without email' do
      user.email = nil
      expect(user).to be_invalid
    end

    describe 'email validation' do
      describe 'email format' do
        it { is_expected.to allow_value('test@test.com').for(:email) }
        it { is_expected.not_to allow_value('invalidemailcom').for(:email) }
        it { is_expected.not_to allow_value('test @test.com').for(:email) }
        it { is_expected.not_to allow_value('tést@test.com').for(:email) }
        it { is_expected.not_to allow_value('däni@test.com').for(:email) }
        it { is_expected.not_to allow_value('test@test').for(:email) }
      end

      describe 'unqueness' do
        it 'validates unqueness' do
          new_user = FactoryBot.build(:user, email: user.email)
          expect(new_user).to be_invalid

          new_user.email = 'something@else.com'

          expect(new_user).to be_valid
        end
      end
    end
  end

  describe 'associations' do
    it { is_expected.to have_many(:trips).dependent(:destroy) }
    it { is_expected.to have_many(:packages).dependent(:destroy) }
    it { is_expected.to have_many(:trip_bookings).through(:trips).source(:bookings) }
    it { is_expected.to have_many(:package_bookings).through(:packages).source(:bookings) }
  end
end
