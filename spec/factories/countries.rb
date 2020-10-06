FactoryBot.define do
  factory :country do
    sequence(:name) { |i| 'Country ' + (1..999).to_a[i].to_s }
    sequence(:code) { |i| ('AA'...'ZZ').to_a[i] }
  end
end

# == Schema Information
#
# Table name: countries
#
#  code       :string           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
