class PatientAppointment < ApplicationRecord
  belongs_to :user
  belongs_to :agent
end
