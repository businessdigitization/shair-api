module Entities
  class Base < Grape::Entity
    format_with(:float, &:to_f)
    format_with(:iso_date) { |date| date.to_date.iso8601 if date.present? }
    format_with(:iso_time) { |time| time.iso8601 if time.present? }
  end
end
