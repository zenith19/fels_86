class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :firstname
      t.string :lastname
      t.integer :rank
      t.boolean :active, default: true

      t.timestamps null: false
    end
  end
end
