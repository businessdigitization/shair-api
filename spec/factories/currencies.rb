# == Schema Information
#
# Table name: currencies
#
#  code       :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :currency do
    name { 'Bangladeshi Taka' }
    code { 'BDT' }
  end
end
