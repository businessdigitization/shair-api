# == Schema Information
#
# Table name: packages
#
#  id                       :bigint           not null, primary key
#  delivery_daterange       :daterange
#  departure_airport_code   :string           not null
#  description              :text
#  destination_airport_code :string           not null
#  dispatcher_email         :citext           not null
#  preference               :text
#  status                   :integer          not null
#  weight                   :decimal(10, 2)
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#
# Indexes
#
#  index_packages_on_departure_airport_code    (departure_airport_code)
#  index_packages_on_destination_airport_code  (destination_airport_code)
#  index_packages_on_dispatcher_email          (dispatcher_email)
#
# Foreign Keys
#
#  fk_rails_9e103c4ae1  (departure_airport_code => airports.code)
#  fk_rails_9fa2f5e26f  (destination_airport_code => airports.code)
#  fk_rails_f360845797  (dispatcher_email => users.email)
#
FactoryBot.define do
  factory :package do
    description { 'My Precious' }
    association :departure, factory: :airport
    association :destination, factory: :airport
    association :dispatcher, factory: :user
    weight { 5 }
    status { 'draft' }
  end
end
