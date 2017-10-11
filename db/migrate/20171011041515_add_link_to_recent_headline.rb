class AddLinkToRecentHeadline < ActiveRecord::Migration[5.1]
  def change
    add_column :recent_headlines, :link, :string, null: false, default: ''
  end
end
