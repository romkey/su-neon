class CreateConfigs < ActiveRecord::Migration[5.1]
  def change
    create_table :configs do |t|
      t.string :particle_access_token, null: false

      t.timestamps
    end
  end
end
