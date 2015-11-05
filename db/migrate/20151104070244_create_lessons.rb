class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.references :user
      t.references :category
      t.integer :result

      t.timestamps null: false
    end
  end
end
