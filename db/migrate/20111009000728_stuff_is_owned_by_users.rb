class StuffIsOwnedByUsers < ActiveRecord::Migration
  def up
    add_column :characters, :user_id, :integer
    add_column :locations, :user_id, :integer
    add_index :characters, :user_id
    add_index :locations, :user_id
  end

  def down
    remove_index :locations, :user_id
    remove_index :characters, :user_id
    remove_column :locations, :user_id
    remove_column :characters, :user_id
  end
end
