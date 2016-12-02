class RenameAnswerChoice < ActiveRecord::Migration
  def change
    rename_column :answer_choices, :answer, :text
  end
end
