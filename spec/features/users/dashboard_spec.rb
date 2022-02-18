require 'rails_helper'

RSpec.describe 'users dashboard' do

  before :each do
    @user1 = create :user
    @user2 = create :user
    @user3 = create :user
  end

  it 'displays the users name at the top of the page' do
    visit user_path(@user1)
    expect(page).to have_content "#{@user1.name}'s Dashboard"

    visit user_path(@user2)
    expect(page).to have_content "#{@user2.name}'s Dashboard"
  end

  it 'displays a button that links to Discover Movies' do
    visit user_path(@user1)

    within("#discover_movies") do
      expect(page).to have_button("Discover Movies")
      click_on "Discover Movies"
      expect(current_path).to eq("/users/#{@user1.id}/discover")
    end

    visit user_path(@user2)
    within("#discover_movies") do
      expect(page).to have_button("Discover Movies")
      click_on "Discover Movies"
      expect(current_path).to eq("/users/#{@user2.id}/discover")
    end
  end

  it 'provides a section where any viewing parties are listed' do
    VCR.use_cassette('tmdb_movie_details_with_credits_reviews') do
      VCR.use_cassette('the_godfather') do
        VCR.use_cassette('image') do
          VCR.use_cassette('image_and_data') do
            party1 = Party.create!(host_id: @user1.id, movie_id: 278, length: 142, start_time: "19:00:00", date:  Date.new(2022,04,04))
            party2 = Party.create!(host_id: @user3.id, movie_id: 238, length: 175, start_time: "20:00:00", date:  Date.new(2022,04,05))

            Attendee.create!(user: @user1, party: party1)
            Attendee.create!(user: @user2, party: party1)

            Attendee.create!(user:@user3, party: party2)
            Attendee.create!(user:@user1, party: party2)

            visit user_path(@user1)
            #one created party and one invite
            expect(page).to have_content("It's Party Time!")
            expect(page).to have_content("My Parties")

            within("#party_time_host_#{party1.id}") do
              expect(page).to have_content("Film: The Shawshank Redemption")
              expect(page).to have_content("Date: Mon, April 04, 2022")
              expect(page).to have_content("Time: 07:00PM")
              expect(page).to have_content("Host: #{@user1.name}")
              expect(page).to have_content("Who's Invited?")
              expect(page).to have_content("#{@user1.name}")
              expect(page).to have_content("#{@user2.name}")
            end

            expect(page).to have_content("Parties I've Been Invited To")
            within("#party_time_guest_#{party2.id}") do
              expect(page).to have_content("Film: The Godfather")
              expect(page).to have_content("Date: Tue, April 05, 2022")
              expect(page).to have_content("Time: 08:00PM")
              expect(page).to have_content("Host: #{@user3.name}")
              expect(page).to have_content("Who's Invited?")
              expect(page).to have_content("#{@user1.name}")
              expect(page).to have_content("#{@user3.name}")
            end

            visit user_path(@user2)
            #No created parties, one invite
            expect(page).to have_content("It's Party Time!")
            expect(page).to have_content("Parties I've Been Invited To")

            within("#party_time_guest_#{party1.id}") do
              expect(page).to have_content("Film: The Shawshank Redemption")
              expect(page).to have_content("Date: Mon, April 04, 2022")
              expect(page).to have_content("Time: 07:00PM")
              expect(page).to have_content("Host: #{@user1.name}")
              expect(page).to have_content("Who's Invited?")
              expect(page).to have_content("#{@user1.name}")
              expect(page).to have_content("#{@user2.name}")
            end
            expect(page).to_not have_content("My Parties")


            visit user_path(@user3)
            #One created party, no invites
            expect(page).to have_content("It's Party Time!")
            expect(page).to have_content("My Parties")

            within("#party_time_host_#{party2.id}") do
              expect(page).to have_content("Film: The Godfather")
              expect(page).to have_content("Date: Tue, April 05, 2022")
              expect(page).to have_content("Time: 08:00PM")
              expect(page).to have_content("Host: #{@user3.name}")
              expect(page).to have_content("Who's Invited?")
              expect(page).to have_content("#{@user1.name}")
              expect(page).to have_content("#{@user3.name}")
            end

            expect(page).to_not have_content("Parties I've Been Invited To")
          end
        end
      end
    end
  end

  it 'links to a movies show page', :vcr do
    party1 = Party.create!(host_id: @user1.id, movie_id: 278, length: 142, start_time: "19:00:00", date:  Date.new(2022,04,04))
    Attendee.create!(user: @user1, party: party1)

    visit user_path(@user1)

    within("#party_time_host_#{party1.id}") do
      expect(page).to have_link("The Shawshank Redemption")
      click_on "The Shawshank Redemption"
      expect(current_path).to eq("/users/#{@user1.id}/movies/#{party1.movie_id}")
    end
  end
end
