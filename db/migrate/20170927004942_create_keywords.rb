class CreateKeywords < ActiveRecord::Migration[5.1]
  def change
    create_table :keywords do |t|
      t.string :name, null: false
      t.belongs_to :sign, foreign_key: true

      t.timestamps

      t.index :name
    end
  end
end
