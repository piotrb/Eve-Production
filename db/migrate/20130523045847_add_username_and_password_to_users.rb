class AddUsernameAndPasswordToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :username
      t.string :password_digest
      t.index :username
    end
  end
end
