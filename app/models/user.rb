class User < ApplicationRecord
  has_secure_password
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: {minimum: 3}

  has_many :properties, dependent: :destroy
  has_many :applications, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy



  def full_name
    self.first_name + " " + self.last_name
  end
end
