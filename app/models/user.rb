class User < ApplicationRecord
  # Original REGEX is this https://github.com/ruby/ruby/blob/ruby_2_5/lib/uri/mailto.rb#L56
  # We have modified it to not allow email with format like "something@somewhere"
  EMAIL_REGEXP = /\A[a-zA-Z0-9.!\#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*\.[a-z]{2,}\z/

  has_many :trips, foreign_key: :transporter_id, dependent: :destroy
  has_many :packages, foreign_key: :transiter_id, dependent: :destroy
  has_many :trip_bookings, through: :trips, source: :bookings
  has_many :package_bookings, through: :packages, source: :bookings

  validates :email, format: { with: EMAIL_REGEXP }
  validates :name, :email, presence: true
  validates :email, uniqueness: true

end

# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  email      :citext
#  name       :citext
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
