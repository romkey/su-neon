class CreateNewsSources < ActiveRecord::Migration[5.1]
  def change
    create_table :news_sources do |t|
      t.string :name, null: false
      t.string :feed_url, null: false
      t.integer :lifetime_hits, null: false, default: 0
      t.datetime :last_processed_at

      t.timestamps
    end
  end
end
