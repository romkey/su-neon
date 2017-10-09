class CreateSigns < ActiveRecord::Migration[5.1]
  def change
    create_table :signs do |t|
      t.string :name, null: false
      t.belongs_to :particle_instances, foreign_key: true
      t.integer :relay, null: false

      t.timestamps

      t.index :name
    end
  end
end
