# == Schema Information
#
# Table name: currencies
#
#  id   :bigint           not null, primary key
#  code :string           not null
#  name :string           not null
#
# Indexes
#
#  index_currencies_on_code  (code)
#
FactoryBot.define do
  factory :currency do
    name { 'Bangladeshi Taka' }
    sequence(:code) { |i| ('AAA'...'ZZZ').to_a[i] }
  end
end
