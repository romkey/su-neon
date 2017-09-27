class AddToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :company, :string
    add_column :users, :image_url, :string
    add_column :users, :phone_number, :string
  end
end
