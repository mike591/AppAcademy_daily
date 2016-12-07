class Cat < ActiveRecord::Base
  COLORS = ["Black", "White", "Orange"]

  validates :birth_date, :name, :sex, :description, presence: true
  validates :color, inclusion: { in: COLORS }

  has_many :cat_rental_requests

end
