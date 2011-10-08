class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.string :name
      t.integer :charid
      t.integer :pe_skill
      t.integer :industry_skill

      t.timestamps
    end
  end
end
