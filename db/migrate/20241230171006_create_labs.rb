class CreateLabs < ActiveRecord::Migration[7.2]
  def change
    create_table :labs do |t|
      t.string :name
      t.string :email
      t.string :phone

      t.timestamps
    end
  end
end
