# == Schema Information
#
# Table name: packages
#
#  id                 :bigint           not null, primary key
#  delivery_daterange :daterange
#  description        :text
#  preference         :text
#  status             :integer          not null
#  weight             :decimal(10, 2)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  departure_id       :bigint           not null
#  destination_id     :bigint           not null
#  dispatcher_id      :bigint           not null
#
# Indexes
#
#  index_packages_on_departure_id    (departure_id)
#  index_packages_on_destination_id  (destination_id)
#  index_packages_on_dispatcher_id   (dispatcher_id)
#
# Foreign Keys
#
#  fk_rails_1eabb157c5  (departure_id => airports.id)
#  fk_rails_72648286cc  (destination_id => airports.id)
#  fk_rails_ccab535bef  (dispatcher_id => users.id)
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
