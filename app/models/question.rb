class Question < ApplicationRecord
<<<<<<< HEAD
    has_many :answers, dependent: :destroy
    belongs_to :user
=======
  belongs_to :user
  belongs_to :property

  has_many :answers, dependent: :destroy
>>>>>>> origin/integration
end
