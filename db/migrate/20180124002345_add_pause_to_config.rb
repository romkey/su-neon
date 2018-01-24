class AddPauseToConfig < ActiveRecord::Migration[5.1]
  def change
    add_column :configs, :paused, :boolean, default: false, null: false
  end
end
