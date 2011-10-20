class CreateBlueprints < ActiveRecord::Migration
  def change
    create_table :blueprints do |t|
      t.integer :typeid
      t.integer :material_level
      t.integer :productivity_level
      t.integer :user_id

      t.timestamps
    end
  end
end
