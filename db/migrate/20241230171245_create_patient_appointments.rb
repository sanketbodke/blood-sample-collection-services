class CreatePatientAppointments < ActiveRecord::Migration[7.2]
  def change
    create_table :patient_appointments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :agent, null: false, foreign_key: true
      t.datetime :appointment_time, null: false
      t.string :status, default: "pending"
      t.string :collection_location
      t.text :note

      t.timestamps
    end
  end
end
