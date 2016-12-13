class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :title, null: false
      t.string :details
      t.string :visibility
      t.string :finished
      t.integer :cheers
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
