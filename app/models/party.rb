class Party < ApplicationRecord
  has_many :attendees, dependent: :destroy
  has_many :users, through: :attendees

  validates_presence_of :date,
                        :start_time,
                        :movie_id,
                        :length
end