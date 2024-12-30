class AddFieldsToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :phone, :string
    add_column :users, :dob, :date
    add_column :users, :gender, :string
    add_column :users, :blood_group, :string
    add_column :users, :is_lab, :boolean, default: false
  end
end
