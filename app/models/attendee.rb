class Attendee < ApplicationRecord
  belongs_to :user
  belongs_to :party

  validates_presence_of :role

  enum role: { guest: 0, host: 1 }
end 