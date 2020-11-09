class User < ApplicationRecord
  self.primary_key = 'email'

  # Original REGEX is this https://github.com/ruby/ruby/blob/ruby_2_5/lib/uri/mailto.rb#L56
  # We have modified it to not allow email with format like "something@somewhere"
  EMAIL_REGEXP = /\A[a-zA-Z0-9.!\#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*\.[a-z]{2,}\z/

  has_many :trips, primary_key: :email, foreign_key: :transporter_email, inverse_of: :transporter, dependent: :destroy
  has_many :parcels, primary_key: :email, foreign_key: :dispatcher_email, inverse_of: :dispatcher, dependent: :destroy
  has_many :trip_bookings, through: :trips, source: :bookings
  has_many :parcel_bookings, through: :parcels, source: :bookings

  validates :email, format: { with: EMAIL_REGEXP }
  validates :name, :email, presence: true
  validates :email, uniqueness: true

  has_secure_password
end

# == Schema Information
#
# Table name: users
#
#  email           :citext           not null, primary key
#  name            :citext           not null
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
