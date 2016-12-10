class Comment < ActiveRecord::Base
  validates :author, :post, presence: true

  belongs_to :author,
  foreign_key: :user_id,
  class_name: "User"

  belongs_to :parent_comment,
  class_name: "Comment"

  has_many :child_comments,
  foreign_key: :parent_comment_id,
  class_name: "Comment"

  belongs_to :post
end
