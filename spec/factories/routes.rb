FactoryBot.define do
  factory :route do
    from { 'Kuala Lumpur Airport' }
    to { 'Dhaka International Airport' }
    route_type { :flight }
  end
end
