class Trip < ApplicationRecord
  enum status: { draft: 0, active: 1, outdated: 2 }

  belongs_to :user
  belongs_to :route, optional: true
end
