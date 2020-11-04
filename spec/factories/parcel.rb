# == Schema Information
#
# Table name: parcels
#
#  id                       :bigint           not null, primary key
#  description              :text
#  destination_airport_code :string           not null
#  dispatcher_email         :citext           not null
#  origin_airport_code      :string           not null
#  preference               :text
#  status                   :integer          not null
#  weight                   :decimal(10, 2)
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#
# Indexes
#
#  index_parcels_on_destination_airport_code  (destination_airport_code)
#  index_parcels_on_dispatcher_email          (dispatcher_email)
#  index_parcels_on_origin_airport_code       (origin_airport_code)
#
# Foreign Keys
#
#  fk_rails_9fa2f5e26f  (destination_airport_code => airports.code)
#  fk_rails_f360845797  (dispatcher_email => users.email)
#  fk_rails_f4ca4bc327  (origin_airport_code => airports.code)
#
FactoryBot.define do
  factory :parcel do
    description { 'My Precious' }
    association :origin, factory: :airport
    association :destination, factory: :airport
    association :dispatcher, factory: :user
    weight { 5 }
    status { 'draft' }
  end
end
