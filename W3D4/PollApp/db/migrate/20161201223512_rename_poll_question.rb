class RenamePollQuestion < ActiveRecord::Migration
  def change
    rename_column :questions, :poll_question, :text
  end
end
