FactoryBot.define do
  factory :date_range do
    starts_at { Time.zone.today }
    ends_at { 1.day.after }
  end
end
