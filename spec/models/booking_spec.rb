require 'rails_helper'

RSpec.describe Booking do
  it 'has a valid factory' do
    factory = FactoryBot.build(:booking)
    expect(factory).to be_valid
  end

  describe 'association' do
    it { is_expected.to belong_to(:trip).inverse_of(:bookings) }
    it { is_expected.to belong_to(:parcel).inverse_of(:bookings) }
    it { is_expected.to belong_to(:currency) }
  end

  describe 'delegation' do
    it { is_expected.to delegate_method(:dispatcher).to(:parcel) }
    it { is_expected.to delegate_method(:transporter).to(:trip) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:status) }
    it { is_expected.to validate_presence_of(:status) }

    describe 'proposed price' do
      it 'is invalid without any proposed price' do
        booking = FactoryBot.build(:booking, dispatcher_proposed_price: nil, transporter_proposed_price: nil)
        expect(booking).to be_invalid
      end

      it 'requires at least on proposed price' do
        booking = FactoryBot.build(:booking, dispatcher_proposed_price: 30, transporter_proposed_price: nil)
        expect(booking).to be_valid
      end
    end

    describe 'different user as dispatcher and transporter' do
      let!(:user_1) { FactoryBot.create(:user) }
      let!(:user_2) { FactoryBot.create(:user) }

      let!(:trip) { FactoryBot.create(:trip, transporter: user_1) }
      let!(:parcel) { FactoryBot.create(:parcel, dispatcher: user_1) }

      let!(:booking) { FactoryBot.build(:booking, trip: trip, parcel: parcel) }

      context 'dispatcher and transporter is same user' do
        specify { expect(booking).to be_invalid }
      end

      context 'dispatcher and transporter is same user' do
        before do
          parcel.update(dispatcher: user_2)
          parcel.reload
        end

        specify { expect(booking).to be_valid }
      end
    end
  end

  describe 'callbacks' do
    describe 'after intialize' do
      it 'sets status to :draft and assign a number' do
        booking = Booking.new
        expect(booking.status).to eq('proposed')
        expect(booking.number).to_not be_nil
      end
    end
  end
end
