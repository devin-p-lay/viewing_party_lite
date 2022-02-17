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
        user = create :user
        party1 = create :party, { host_id: user.id }

        expect(party1.whos_hosting?).to eq("#{user.name}")
      end
    end
  end
end
