class Property < ApplicationRecord
  belongs_to :user
  has_many :questions, dependent: :destroy
  has_many :answers, through: :questions, source: :user
  has_many :applications, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true
  validates :location, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :amenities, presence: true
end

