class User < ApplicationRecord
  validates :name, :email, presence: true


  # Original REGEX is this https://github.com/ruby/ruby/blob/ruby_2_5/lib/uri/mailto.rb#L56
  # We have modified it to not allow email with format like "something@somewhere"
  EMAIL_REGEXP = /\A[a-zA-Z0-9.!\#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*\.[a-z]{2,}\z/

  validates :email, format: { with: EMAIL_REGEXP }
end
