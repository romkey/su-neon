class CreateKeywordsSigns < ActiveRecord::Migration[5.1]
  def change
    create_table :keywords_signs, id: false do |t|
      t.belongs_to :keyword, index: true
      t.belongs_to :sign, index: true
      t.timestamps
    end
  end
end
