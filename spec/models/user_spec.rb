require 'rails_helper'

        RSpec.describe User do
describe 'validations' do
    let(:user) {FactoryBot.build(:user,name: 'Faruk',email: 'faruk@gmail.com') }

    it 'is not valid without name' do
    user.name=nil
      expect(user.valid?).to eq(false )
    end

        it "is not valid without email" do
      user.email =nil
      expect(user.valid?).to eq(false )
    end
  end
end
