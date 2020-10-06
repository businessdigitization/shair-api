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
#  id           :bigint           not null, primary key
#  country_code :string           not null
#  name         :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_cities_on_country_code  (country_code)
#
# Foreign Keys
#
#  fk_rails_3a43dc511e  (country_code => countries.code)
#
