class Step < ApplicationRecord
  validates :title, :body, presence: true

  belongs_to :todo

end
