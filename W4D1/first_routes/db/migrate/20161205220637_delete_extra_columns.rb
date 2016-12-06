class DeleteExtraColumns < ActiveRecord::Migration
  def change
    # remove_column :table_name, :column_name
    remove_column :users, :name
    remove_column :users, :email

    # add_column :users, :home_page_url, :string
    add_column :users, :username, :string
  end
end
