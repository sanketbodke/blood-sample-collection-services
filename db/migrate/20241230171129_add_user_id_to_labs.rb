class AddUserIdToLabs < ActiveRecord::Migration[7.2]
  def change
    add_column :labs, :user_id, :integer
    add_index :labs, :user_id
  end
end
