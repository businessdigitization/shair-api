# == Schema Information
#
# Table name: currencies
#
#  code :string           not null, primary key
#  name :string           not null
#
FactoryBot.define do
  factory :currency do
    name { 'Bangladeshi Taka' }
    sequence(:code) { |i| ('AAA'...'ZZZ').to_a[i] }
  end
end
