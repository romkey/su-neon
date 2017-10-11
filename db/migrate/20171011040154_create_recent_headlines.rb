class CreateRecentHeadlines < ActiveRecord::Migration[5.1]
  def change
    create_table :recent_headlines do |t|
      t.string :headline, null: false
      t.belongs_to :news_source, foreign_key: true

      t.timestamps
    end
  end
end
