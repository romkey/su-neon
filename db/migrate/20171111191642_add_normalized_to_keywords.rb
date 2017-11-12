class AddNormalizedToKeywords < ActiveRecord::Migration[5.1]
  def change
    add_column :keywords, :normalized, :string
    add_index :keywords, :normalized

    Keyword.all.find_each do |keyword|
      keyword.update_attributes(normalized: keyword.normalized! || '')
    end

    change_column :keywords, :normalized, :string, null: false, unique: true
  end
end
