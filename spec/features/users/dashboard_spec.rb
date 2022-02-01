require 'rails_helper'

RSpec.describe 'users dashboard' do

  before :each do
    @user_1 = User.create!(name: "Bob Barker", email: "BobBarker@example.com")
    @user_2 = User.create!(name: "Jeff Lebowski", email: "TheDude@example.com")
    @user_3 = User.create!(name: "Eyore", email: "NoFriends@example.com")
  end

  it 'dsplays the users name at the top of the page' do
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
    party_1 = Party.create!(date: Time.current, start_time: Time.current, movie_title: "Big Lebowski", movie_runtime: "12345")
    Attendee.create!(user: @user_1, party: party_1, role: 1)
    Attendee.create!(user: @user_2, party: party_1, role: 0)

    visit user_dashboard_path(@user_1)

    expect(page).to have_content("It's Party Time!")

    within("#party_time_#{party_1.id}") do
      expect(page).to have_content("Movie: Big Lebowski")
      expect(page).to have_content("Runtime: 12345")
      expect(page).to have_content("Date: #{party_1.date}")
      expect(page).to have_content("Start time: #{party_1.start_time}")
    end

    visit user_dashboard_path(@user_2)

    expect(page).to have_content("It's Party Time!")

    within("#party_time_#{party_1.id}") do
      expect(page).to have_content("Movie: Big Lebowski")
      expect(page).to have_content("Runtime: 12345")
      expect(page).to have_content("Date: #{party_1.date}")
      expect(page).to have_content("Start time: #{party_1.start_time}")
    end

    visit user_dashboard_path(@user_3)

    expect(page).to have_content("It's Party Time!")

    expect(page).to_not have_content("Movie: Big Lebowski")
    expect(page).to_not have_content("Runtime: 12345")
    expect(page).to_not have_content("Date: #{party_1.date}")
    expect(page).to_not have_content("Start time: #{party_1.start_time}")
  end
end
