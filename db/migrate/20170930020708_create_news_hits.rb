class CreateNewsHits < ActiveRecord::Migration[5.1]
  def change
    create_table :news_hits do |t|
      t.belongs_to :news_source, foreign_key: true, null: false
      t.belongs_to :keyword, foreign_key: true, null: false

      t.timestamps
    end
  end
end
