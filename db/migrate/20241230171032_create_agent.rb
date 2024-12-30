class CreateAgent < ActiveRecord::Migration[7.2]
  def change
    create_table :agents do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.references :lab, null: false, foreign_key: true

      t.timestamps
    end
  end
end
