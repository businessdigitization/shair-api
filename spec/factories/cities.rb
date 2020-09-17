FactoryBot.define do
  factory :city do
    sequence(:name) { |i| 'City ' + (1..999).to_a[i].to_s }
    association :country, factory: :country
  end
end

# == Schema Information
#
# Table name: cities
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  country_id :bigint           not null
#
# Indexes
#
#  index_cities_on_country_id  (country_id)
#
