class CreatePrices < ActiveRecord::Migration
  def self.up
    create_table :prices do |t|
      t.float :price
      t.integer :typeID
      t.integer :location_id
      t.timestamps
    end
    add_index :prices, :typeID
    add_index :prices, :location_id
  end

  def self.down
    remove_index :prices, :location_id
    remove_index :prices, :typeID
    drop_table :prices
  end
end