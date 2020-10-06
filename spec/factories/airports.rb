FactoryBot.define do
  factory :airport do
    sequence(:name) { |i| 'Airport ' + (1..999).to_a[i].to_s }
    sequence(:code) { |i| ('AAA'...'ZZZ').to_a[i] }
    association :city, factory: :city
  end
end

# == Schema Information
#
# Table name: airports
#
#  code       :string           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  city_id    :bigint
#
# Indexes
#
#  index_airports_on_city_id  (city_id)
#  index_airports_on_name     (name)
#
