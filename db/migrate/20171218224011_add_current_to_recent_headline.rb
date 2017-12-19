class AddCurrentToRecentHeadline < ActiveRecord::Migration[5.1]
  def change
    add_column :recent_headlines, :current, :boolean, default: false, null: false
  end
end
