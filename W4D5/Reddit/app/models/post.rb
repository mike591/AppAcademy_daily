class Post < ActiveRecord::Base
  validates :title, :author, :subs, presence: true

  belongs_to :author,
  foreign_key: :user_id,
  class_name: "User"

  has_many :post_subs

  has_many :subs,
  through: :post_subs,
  source: :sub

  has_many :comments

  def top_level_comments
    comments.where(parent_comment_id: nil)
  end

  def comments_by_parent_id
    hash = Hash.new { |h, k| h[k] = [] }
    comments.each do |comment|
      hash[comment.parent_comment_id] << comment
    end
    hash
  end
end
