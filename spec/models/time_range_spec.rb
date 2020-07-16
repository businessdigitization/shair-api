require 'rails_helper'

RSpec.describe TimeRange do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:starts_at) }

    describe 'timeline validation' do
      let(:invalid_time_range) { FactoryBot.build(:time_range, starts_at: DateTime.current, ends_at: 2.days.ago) }
      let(:valid_time_range) { FactoryBot.build(:time_range, starts_at: DateTime.current, ends_at: 2.days.after) }

      it 'not valid if starts_at is greater than ends_at' do
        expect(invalid_time_range).to_not be_valid
      end

      it 'valid if starts_at is smaller than ends_at' do
        expect(valid_time_range).to be_valid
      end
    end
  end
end
