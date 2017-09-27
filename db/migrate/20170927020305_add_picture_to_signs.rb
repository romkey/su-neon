class AddPictureToSigns < ActiveRecord::Migration[5.1]
  def change
    add_column :signs, :picture, :string
  end
end
