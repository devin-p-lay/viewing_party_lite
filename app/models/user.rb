class User < ApplicationRecord
  has_many :attendees, dependent: :destroy
  has_many :parties, through: :attendees

  validates :email, uniqueness: true, presence: true
  validates_presence_of :name, :password
  has_secure_password
end