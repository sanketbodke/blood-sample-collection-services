class AddTestTypeToPatientAppointments < ActiveRecord::Migration[7.2]
  def change
    add_column :patient_appointments, :test_type, :string
  end
end
