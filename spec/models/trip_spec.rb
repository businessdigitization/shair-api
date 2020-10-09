require 'rails_helper'

RSpec.describe Trip do
  it 'has a valid factory' do
    factory = FactoryBot.build(:trip)
    expect(factory).to be_valid
  end

  describe 'validation' do
    it { is_expected.to validate_presence_of(:status) }

    describe 'arrival and origin time validation' do
      let(:trip) do
        FactoryBot.create(
          :trip,
          departure_at: Time.zone.today,
          arrival_at: Time.zone.tomorrow
        )
      end

      it 'fails validation if arrival is before departure' do
        expect(trip).to be_valid

        trip.arrival_at = Time.zone.yesterday

        expect(trip).to_not be_valid
      end
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:transporter).inverse_of(:trips) }
    it { is_expected.to belong_to(:origin).inverse_of(:outgoing_trips) }
    it { is_expected.to belong_to(:destination).inverse_of(:incoming_trips) }
    it { is_expected.to have_one(:pricing).dependent(:destroy).inverse_of(:trip) }
    it { is_expected.to have_many(:bookings).inverse_of(:trip) }
    it { is_expected.to accept_nested_attributes_for(:pricing) }
  end

  describe 'callbacks' do
    describe 'after intialize' do
      it 'sets status to :draft' do
        trip = Trip.new
        expect(trip.status).to eq('draft')
      end
    end
  end
end
