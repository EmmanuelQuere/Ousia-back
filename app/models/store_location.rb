class StoreLocation < ApplicationRecord
  validates :name, presence: true
  validates :lng, presence: true
  validates :lat, presence: true
  validates :category, presence: true, inclusion: { in: %w(retail consumption),
    message: "%{value} is not a valid category" }
  enum category: {retail: 'retail', consumption: 'consumption'}
end
