class Track < ActiveRecord::Base
  validates :name, presence: true, length: { minimum: 1 }
  validates :album_id, presence: true
  validates :track_type, inclusion: { in: ["bonus", "regular"] }

  belongs_to :album,
  primary_key: :id,
  foreign_key: :album_id,
  class_name: "Album"

end
