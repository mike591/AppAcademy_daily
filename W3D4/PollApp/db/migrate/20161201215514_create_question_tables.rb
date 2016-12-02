class CreateQuestionTables < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :poll_question, null: false
      t.integer :poll_id, null: false

      t.timestamps
    end
  end
end
