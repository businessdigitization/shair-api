# == Schema Information
#
# Table name: trips
#
#  id               :bigint           not null, primary key
#  arrival_time     :datetime
#  date             :date
#  departure_time   :datetime
#  luggage_capacity :decimal(5, 2)
#  preference       :text
#  status           :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  departure_id     :bigint           not null
#  destination_id   :bigint           not null
#  transporter_id   :bigint           not null
#
# Indexes
#
#  index_trips_on_date            (date)
#  index_trips_on_departure_id    (departure_id)
#  index_trips_on_destination_id  (destination_id)
#  index_trips_on_status          (status)
#  index_trips_on_transporter_id  (transporter_id)
#
# Foreign Keys
#
#  fk_rails_1853b836c1  (transporter_id => users.id)
#  fk_rails_447da15f04  (destination_id => airports.id)
#  fk_rails_dfa65b25bf  (departure_id => airports.id)
#
FactoryBot.define do
  factory :trip do
    association :departure, factory: :airport
    association :destination, factory: :airport
    date { 7.days.since }
    status { :draft }
    association :transporter, factory: :user
  end
end
