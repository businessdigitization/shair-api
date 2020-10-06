# == Schema Information
#
# Table name: users
#
#  email      :citext           not null, primary key
#  name       :citext
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :user do
    name { 'Faruk Hossain' }
    sequence(:email) { |i| ('aaa'..'zzz').to_a[i] + 'faruk@mail.com' }
  end
end
