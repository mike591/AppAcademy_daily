class Band < ActiveRecord::Base
  validates :name, presence: true, length: { minimum: 1 }

  has_many :albums,
  primary_key: :id,
  foreign_key: :band_id,
  class_name: "Album"
end
