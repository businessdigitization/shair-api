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
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
FactoryBot.define do
  factory :user do
    name { 'Faruk Hossain' }
    sequence(:email) { |i| ('aaa'..'zzz').to_a[i] + 'faruk@mail.com' }
  end
end
