require 'rails_helper'

describe Party do
  describe 'relationships' do
    it { should have_many(:attendees) }
    it { should have_many(:users).through(:attendees) }
  end

  describe 'validations' do
    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:start_time) }
    it { should validate_presence_of(:movie_title) }
    it { should validate_presence_of(:movie_runtime) }
  end
end