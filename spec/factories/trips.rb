# == Schema Information
#
# Table name: trips
#
#  id                       :bigint           not null, primary key
#  arrival_at               :datetime
#  departure_airport_code   :string           not null
#  departure_at             :datetime
#  destination_airport_code :string           not null
#  luggage_capacity         :decimal(5, 2)
#  preference               :text
#  status                   :integer          not null
#  transporter_email        :citext           not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#
# Indexes
#
#  index_trips_on_arrival_at                (arrival_at)
#  index_trips_on_departure_airport_code    (departure_airport_code)
#  index_trips_on_departure_at              (departure_at)
#  index_trips_on_destination_airport_code  (destination_airport_code)
#  index_trips_on_status                    (status)
#  index_trips_on_transporter_email         (transporter_email)
#
# Foreign Keys
#
#  fk_rails_26127287aa  (departure_airport_code => airports.code)
#  fk_rails_74bfde5700  (destination_airport_code => airports.code)
#  fk_rails_fc6bcf6577  (transporter_email => users.email)
#
FactoryBot.define do
  factory :trip do
    association :departure, factory: :airport
    association :destination, factory: :airport
    departure_at { 7.days.after }
    arrival_at { 7.days.after + 5.hours }
    status { :draft }
    association :transporter, factory: :user
  end
end
