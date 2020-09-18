require 'rails_helper'

RSpec.describe Booking do
  it 'has a valid factory' do
    factory = FactoryBot.build(:booking)
    expect(factory).to be_valid
  end

  describe 'association' do
    it { is_expected.to belong_to(:trip).inverse_of(:bookings) }
    it { is_expected.to belong_to(:package).inverse_of(:bookings) }
    it { is_expected.to belong_to(:currency) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:status) }

    describe 'proposed price' do
      it 'is invalid without any proposed price' do
        booking = FactoryBot.build(:booking, transiter_proposed_price: nil, transporter_proposed_price: nil)
        expect(booking).to be_invalid
      end

      it 'requires at least on proposed price' do
        booking = FactoryBot.build(:booking, transiter_proposed_price: 30, transporter_proposed_price: nil)
        expect(booking).to be_valid
      end
    end

    describe 'different user as transiter and transporter' do
      let!(:user_1) { FactoryBot.create(:user) }
      let!(:user_2) { FactoryBot.create(:user) }

      let!(:trip) { FactoryBot.create(:trip, transporter: user_1) }
      let!(:package) { FactoryBot.create(:package, transiter: user_1) }

      let!(:booking) { FactoryBot.build(:booking, trip: trip, package: package) }

      context 'transiter and transporter is same user' do
        specify { expect(booking).to be_invalid }
      end

      context 'transiter and transporter is same user' do
        before do
          package.update(transiter: user_2)
          package.reload
        end

        specify { expect(booking).to be_valid }
      end
    end
  end
end
