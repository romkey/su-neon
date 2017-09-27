class CreateParticleInstances < ActiveRecord::Migration[5.1]
  def change
    create_table :particle_instances do |t|
      t.string :name, null: false
      t.string :particle_id, null: false

      t.timestamps

      t.index :name
    end
  end
end
