require 'rails_helper'

RSpec.describe Parcel do
  it 'has a valid factory' do
    factory = FactoryBot.build(:parcel)
    expect(factory).to be_valid
  end

  describe 'associations' do
    it { is_expected.to belong_to(:dispatcher).inverse_of(:parcels) }
    it { is_expected.to belong_to(:origin).inverse_of(:outgoing_parcels) }
    it { is_expected.to belong_to(:destination).inverse_of(:incoming_parcels) }
    it { is_expected.to have_many(:items).dependent(:destroy) }
    it { is_expected.to have_many(:bookings).inverse_of(:parcel) }
    it { is_expected.to have_one(:pricing).dependent(:destroy).inverse_of(:parcel) }
    it { is_expected.to accept_nested_attributes_for(:pricing) }
    it { is_expected.to accept_nested_attributes_for(:items) }
  end

  describe 'validation' do
    it { is_expected.to validate_presence_of(:status) }

    context 'status is :published' do
      subject { FactoryBot.build(:parcel, status: :published, items: [], weight: nil) }

      it { is_expected.to validate_presence_of(:items) }
      it { is_expected.to validate_presence_of(:weight) }
    end
  end

  describe 'callbacks' do
    describe 'after intialize' do
      it 'sets status to :draft' do
        parcel = Parcel.new
        expect(parcel.status).to eq('draft')
      end
    end
  end
end
