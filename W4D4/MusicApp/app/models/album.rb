class Album < ActiveRecord::Base
  validates :name, presence: true, length: { minimum: 1 }
  validates :album_type, inclusion: { in: ["live", "studio"] }

  belongs_to :band,
  primary_key: :id,
  foreign_key: :band_id,
  class_name: "Band"

  has_many :tracks,
  primary_key: :id,
  foreign_key: :album_id,
  class_name: "Track"

end
