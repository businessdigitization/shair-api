require 'rails_helper'

RSpec.describe DateRange do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:starts_at) }

    describe 'timeline validation' do
      let(:invalid_date_range) { FactoryBot.build(:date_range, starts_at: Time.zone.today, ends_at: 2.days.ago) }
      let(:valid_date_range) { FactoryBot.build(:date_range, starts_at: Time.zone.today, ends_at: 2.days.after) }

      it 'not valid if starts_at is greater than ends_at' do
        expect(invalid_date_range).to_not be_valid
      end

      it 'valid if starts_at is smaller than ends_at' do
        expect(valid_date_range).to be_valid
      end
    end
  end
end
