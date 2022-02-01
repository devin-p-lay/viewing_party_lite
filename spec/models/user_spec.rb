require 'rails_helper'

describe User do
  describe 'relationships' do
    it { should have_many(:attendees) }
    it { should have_many(:parties).through(:attendees) }
  end

  describe 'validations' do
    # it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
  end
end