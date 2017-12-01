class RenameParticleInstancesIdOnSigns < ActiveRecord::Migration[5.1]
  def change
    rename_column :signs, :particle_instances_id, :particle_instance_id
  end
end
