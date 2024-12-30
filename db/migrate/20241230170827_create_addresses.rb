class CreateAddresses < ActiveRecord::Migration[7.2]
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :city
      t.string :state
      t.string :zip
      t.references :addressable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
