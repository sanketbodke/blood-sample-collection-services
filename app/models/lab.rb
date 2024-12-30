class Lab < ApplicationRecord
  belongs_to :user, optional: true
  has_many :agents
  has_one :address, as: :addressable, dependent: :destroy
  accepts_nested_attributes_for :address

  validates :name, presence: true, length: { minimum: 2, maximum: 100 }
  validates :phone, presence: true, format: { with: /\A\d{10}\z/, message: "must be a valid 10-digit phone number" }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email address" }
end
