class Application < ApplicationRecord
  belongs_to :user
  belongs_to :property

  scope :my_applications, -> { where(user_id: 6) }
end
