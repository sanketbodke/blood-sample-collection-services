class User < ApplicationRecord
  has_one :lab, dependent: :destroy
  has_one :address, as: :addressable, dependent: :destroy
  has_many :patientAppointments
  accepts_nested_attributes_for :address

  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email address" }
end
