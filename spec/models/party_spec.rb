require 'rails_helper'

describe Party do
  describe 'relationships' do
    it { should have_many(:attendees) }
    it { should have_many(:users).through(:attendees) }
  end

  describe 'validations' do
    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:start_time) }
    it { should validate_presence_of(:movie_id) }
    it { should validate_presence_of(:length) }
  end
  
  describe 'instance methods' do
    context '#whos_hosting?' do
      it 'can find a user whos id matches the host id' do
        user_1 = User.create!(name: "Bob Barker", email: "BobBarker@example.com")
        party_1 = Party.create!(host_id: user_1.id, movie_id: 278, length: 142, start_time: "19:00:00", date:  "2022-04-03")

          expect(party_1.whos_hosting?).to eq("Bob Barker")
      end
    end
  end
end
