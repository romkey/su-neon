class AddStatsToSign < ActiveRecord::Migration[5.1]
  def change
    add_column :signs, :hits, :integer, default: 0, null: false
    add_column :signs, :score, :float, default: 0.0, null: false
  end
end
