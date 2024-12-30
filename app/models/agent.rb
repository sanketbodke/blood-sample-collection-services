class Agent < ApplicationRecord
  belongs_to :lab
  has_one :address, as: :addressable, dependent: :destroy
  has_many :patientAppointments
  accepts_nested_attributes_for :address
  before_save :set_latitude_and_longitude

  scope :recently_updated, -> { order(updated_at: :desc) }

  private
  def set_latitude_and_longitude
    if address.city.present?
      location = "#{address.city}, #{address.zip}"
      coordinates = Geocoder.search(location).first&.coordinates

      latitude_adjustment = rand(-0.09..0.135)
      longitude_adjustment = rand(-0.09..0.135)

      if coordinates
        self.address.latitude = coordinates[0] + (0.5 + latitude_adjustment)
        self.address.longitude = coordinates[1] + (0.5 + longitude_adjustment)
      end
    end
  end
end
