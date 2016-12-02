class Response < ActiveRecord::Base
  validates :answer_id,:user_id, presence: true
  validate :respondent_already_answered

  belongs_to :respondent,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  belongs_to :answer_choice,
    primary_key: :id,
    foreign_key: :answer_id,
    class_name: :AnswerChoice

  has_one :question,
    through: :answer_choice,
    source: :question


  def sibling_responses
    current_id = self.id

    self
      .question
      .responses
      .where.not(id: current_id)

  end

  def respondent_already_answered
    if sibling_responses.exists?(user_id: self.user_id)
      errors[:respondent_already_answered] << "Cannot answer again."
    end
  end


end
