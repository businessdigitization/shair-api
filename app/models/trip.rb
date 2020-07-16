class Trip < ApplicationRecord
  enum status: { planning: 0, planned: 1, outdated: 2 }

  belongs_to :user
  belongs_to :route, optional: true
  belongs_to :journey_date_range, class_name: 'DateRange', foreign_key: :date_range_id, optional: true
  belongs_to :journey_time_range, class_name: 'TimeRange', foreign_key: :time_range_id, optional: true
end
