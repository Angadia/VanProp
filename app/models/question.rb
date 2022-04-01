class Question < ApplicationRecord
  belongs_to :user
  belongs_to :property

  has_many :answers, dependent: :destroy

  # questions answered by the current user
  scope :answered_questions, -> { joins(:answers).where(answers: { user_id: 1 }) }

  scope :my_questions, -> { where(user_id: 1) }
end
