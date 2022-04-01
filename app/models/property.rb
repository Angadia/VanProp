class Property < ApplicationRecord
  belongs_to :user

  has_many :questions, dependent: :destroy
  has_many :applications, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true
  validates :location, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :amenities, presence: true

  scope :my_properties, -> { where(user_id: 1) }

  # properties with applications status as :pending
  scope :pending_applications, -> { where(id: Property.my_properties).joins(:applications).where(applications: { status: :pending }).group(:id) }

  # properties with displayed questions unanswered by property administrator
  scope :pending_questions, -> { where(id: Property.my_properties).joins(:questions).where(questions: { display: true }).where.not(questions: { id: Question.answered_questions }) }
end
