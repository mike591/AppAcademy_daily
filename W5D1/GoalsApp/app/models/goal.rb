class Goal < ActiveRecord::Base
  validates :title, :details, presence: true
  belongs_to :user
end
