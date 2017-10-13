class AddThresholdToConfig < ActiveRecord::Migration[5.1]
  def change
    add_column :configs, :threshold, :integer
  end
end
