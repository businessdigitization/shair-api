class DateRange < ApplicationRecord
  validates :starts_at, :ends_at, presence: true
  validate :timeline

  private

  def timeline
    return unless starts_at.present? && ends_at.present?

    errors.add(:invalid_timeline, 'start day can not be after end day') if starts_at > ends_at
  end
end
