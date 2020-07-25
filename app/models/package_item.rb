class PackageItem < ApplicationRecord
  belongs_to :package

  validates :name, :count, presence: true
end
