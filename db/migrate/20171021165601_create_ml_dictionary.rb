class CreateMlDictionary < ActiveRecord::Migration[5.1]
  def change
    create_table :ml_dictionaries do |t|
      t.string :word, null: false, unique: true
    end

    add_index :ml_dictionaries, :word
  end
end
