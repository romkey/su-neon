class AddLitToSign < ActiveRecord::Migration[5.1]
  def change
    add_column :signs, :lit, :boolean, null: false, default: false
  end
end
