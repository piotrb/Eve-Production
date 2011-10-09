class CreatePrices < ActiveRecord::Migration
  def self.up
    create_table :prices do |t|
      t.float :price
      t.integer :typeid
      t.integer :location_id
      t.timestamps
    end
    add_index :prices, :typeid
    add_index :prices, :location_id
  end

  def self.down
    remove_index :prices, :location_id
    remove_index :prices, :typeid
    drop_table :prices
  end
end