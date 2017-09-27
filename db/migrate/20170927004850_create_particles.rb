class CreateParticles < ActiveRecord::Migration[5.1]
  def change
    create_table :particles do |t|
      t.string :name, null: false
      t.string :particle_id, null: false

      t.timestamps

      t.index :name
    end
  end
end
