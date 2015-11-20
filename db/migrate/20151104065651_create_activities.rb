class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer :target_id
      t.references :user
      t.integer :action_type

      t.timestamps null: false
    end
  end
end
