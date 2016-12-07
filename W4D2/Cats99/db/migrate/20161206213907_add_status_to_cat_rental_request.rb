class AddStatusToCatRentalRequest < ActiveRecord::Migration
  def change
    add_column :cat_rental_requests, :status, :string, default: 'PENDING'
    add_index :cat_rental_requests, :cat_id
  end
end
