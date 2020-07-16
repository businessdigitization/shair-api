FactoryBot.define do
  factory :time_range do
    starts_at { DateTime.current.change({ hour: 5 }) }
    ends_at { 1.day.after.change({ hour: 10 }) }
  end
end
