# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  email      :citext
#  name       :citext
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :user do
    name { 'Faruk Hossain' }
    email { 'faruk@mail.com' }
  end
end
