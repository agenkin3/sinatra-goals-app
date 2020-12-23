class CreateGoalEntries < ActiveRecord::Migration
  def change
    create_table :goal_entries do |t|
      t.string :content
      t.integer :user_id
      t.string :month
      t.integer :year
      t.timestamps null: false
    end
  end
end
