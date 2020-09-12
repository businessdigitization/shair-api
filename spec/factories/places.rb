# == Schema Information
#
# Table name: places
#
#  id         :bigint           not null, primary key
#  name       :citext
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :place do
    name { 'London' }

    factory :place_kl do
      name { 'Kuala Lumpur' }
    end

    factory :place_dhaka do
      name { 'Dhaka' }
    end
  end
end
