FactoryBot.define do
  factory :date_range do
    starts_at { Date.current }
    ends_at { 1.day.after }
  end
end
