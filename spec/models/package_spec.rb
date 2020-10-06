require 'rails_helper'

RSpec.describe Package do
  it 'has a valid factory' do
    factory = FactoryBot.build(:package)
    expect(factory).to be_valid
  end

  describe 'associations' do
    it { is_expected.to belong_to(:dispatcher).inverse_of(:packages) }
    it { is_expected.to belong_to(:departure).inverse_of(:outgoing_packages) }
    it { is_expected.to belong_to(:destination).inverse_of(:incoming_packages) }
    it { is_expected.to have_many(:items).dependent(:destroy) }
    it { is_expected.to have_many(:bookings).inverse_of(:package) }
    it { is_expected.to have_one(:pricing).dependent(:destroy).inverse_of(:package) }
  end

  describe 'validation' do
    it { is_expected.to validate_presence_of(:status) }
  end

  describe 'callbacks' do
    describe 'after intialize' do
      it 'sets status to :draft' do
        package = Package.new
        expect(package.status).to eq('draft')
      end
    end
  end
end
