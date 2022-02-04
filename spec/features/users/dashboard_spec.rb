require 'rails_helper'

RSpec.describe 'users dashboard' do

  before :each do
    @user_1 = User.create!(name: "Bob Barker", email: "BobBarker@example.com")
    @user_2 = User.create!(name: "Jeff Lebowski", email: "TheDude@example.com")
    @user_3 = User.create!(name: "Eyore", email: "NoFriends@example.com")
  end

  it 'displays the users name at the top of the page' do
    visit user_dashboard_path(@user_1)
    expect(page).to have_content("Bob Barker's Dashboard")

    visit user_dashboard_path(@user_2)
    expect(page).to have_content("Jeff Lebowski's Dashboard")
  end

  it 'displays a button that links to Discover Movies' do
    visit user_dashboard_path(@user_1)

    within("#discover_movies") do
      expect(page).to have_button("Discover Movies")
      click_on "Discover Movies"
      expect(current_path).to eq("/users/#{@user_1.id}/discover")
    end

    visit user_dashboard_path(@user_2)
    within("#discover_movies") do
      expect(page).to have_button("Discover Movies")
      click_on "Discover Movies"
      expect(current_path).to eq("/users/#{@user_2.id}/discover")
    end
  end

  it 'provides a section where any viewing parties are listed' do
    VCR.use_cassette('tmdb_movie_details_with_credits_reviews') do
      VCR.use_cassette('the_godfather') do
        VCR.use_cassette('image') do
          VCR.use_cassette('image_and_data') do
            party_1 = Party.create!(host_id: @user_1.id, movie_id: 278, length: 142, start_time: "19:00:00", date:  Date.new(2022,04,04))
            party_2 = Party.create!(host_id: @user_3.id, movie_id: 238, length: 175, start_time: "20:00:00", date:  Date.new(2022,04,05))

            Attendee.create!(user: @user_1, party: party_1)
            Attendee.create!(user: @user_2, party: party_1)

            Attendee.create!(user:@user_3, party: party_2)
            Attendee.create!(user:@user_1, party: party_2)

            visit user_dashboard_path(@user_1)
            #one created party and one invite
            expect(page).to have_content("It's Party Time!")
            expect(page).to have_content("My Parties")

            within("#party_time_host_#{party_1.id}") do
              expect(page).to have_content("Film: The Shawshank Redemption")
              expect(page).to have_content("Date: Mon, April 04, 2022")
              expect(page).to have_content("Time: 07:00PM")
              expect(page).to have_content("Host: Bob Barker")
              expect(page).to have_content("Who's Invited?")
              expect(page).to have_content("Bob Barker")
              expect(page).to have_content("Jeff Lebowski")
            end

            expect(page).to have_content("Parties I've Been Invited To")
            within("#party_time_guest_#{party_2.id}") do
              expect(page).to have_content("Film: The Godfather")
              expect(page).to have_content("Date: Tue, April 05, 2022")
              expect(page).to have_content("Time: 08:00PM")
              expect(page).to have_content("Host: Eyore")
              expect(page).to have_content("Who's Invited?")
              expect(page).to have_content("Bob Barker")
              expect(page).to have_content("Eyore")
            end

            visit user_dashboard_path(@user_2)
            #No created parties, one invite
            expect(page).to have_content("It's Party Time!")
            expect(page).to have_content("Parties I've Been Invited To")

            within("#party_time_guest_#{party_1.id}") do
              expect(page).to have_content("Film: The Shawshank Redemption")
              expect(page).to have_content("Date: Mon, April 04, 2022")
              expect(page).to have_content("Time: 07:00PM")
              expect(page).to have_content("Host: Bob Barker")
              expect(page).to have_content("Who's Invited?")
              expect(page).to have_content("Bob Barker")
              expect(page).to have_content("Jeff Lebowski")
            end
            expect(page).to_not have_content("My Parties")


            visit user_dashboard_path(@user_3)
            #One created party, no invites
            expect(page).to have_content("It's Party Time!")
            expect(page).to have_content("My Parties")

            within("#party_time_host_#{party_2.id}") do
              expect(page).to have_content("Film: The Godfather")
              expect(page).to have_content("Date: Tue, April 05, 2022")
              expect(page).to have_content("Time: 08:00PM")
              expect(page).to have_content("Host: Eyore")
              expect(page).to have_content("Who's Invited?")
              expect(page).to have_content("Bob Barker")
              expect(page).to have_content("Eyore")
            end

            expect(page).to_not have_content("Parties I've Been Invited To")
          end
        end
      end
    end
  end

  it 'links to a movies show page', :vcr do
    party_1 = Party.create!(host_id: @user_1.id, movie_id: 278, length: 142, start_time: "19:00:00", date:  Date.new(2022,04,04))
    Attendee.create!(user: @user_1, party: party_1)

    visit user_dashboard_path(@user_1)

    within("#party_time_host_#{party_1.id}") do
      expect(page).to have_link("The Shawshank Redemption")
      click_on "The Shawshank Redemption"
      expect(current_path).to eq("/users/#{@user_1.id}/movies/#{party_1.movie_id}")
    end
  end
end
