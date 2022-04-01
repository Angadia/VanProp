class Question < ApplicationRecord
  belongs_to :user
  belongs_to :property

  has_many :answers, dependent: :destroy
end
