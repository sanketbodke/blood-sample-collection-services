class AddLatitudeAndLongitudeToAddresses < ActiveRecord::Migration[7.2]
  def change
    add_column :addresses, :latitude, :decimal
    add_column :addresses, :longitude, :decimal
  end
end
