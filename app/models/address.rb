class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true

  validates :street, presence: true, length: { maximum: 255 }
  validates :city, presence: true, length: { maximum: 100 }
  validates :state, presence: true, length: { maximum: 100 }
  validates :zip, presence: true
end
