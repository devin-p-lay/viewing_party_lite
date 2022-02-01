require 'rails_helper'

RSpec.describe 'users dashboard' do

  before :each do
    @user_1 = User.create!(name: "Bob Barker", email: "BobBarker@example.com")
    @user_2 = User.create!(name: "Jeff Lebowski", email: "TheDude@example.com")
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

  end
end
