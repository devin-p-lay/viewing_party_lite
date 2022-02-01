require 'rails_helper'

describe 'welcome page' do
  before do
    @user1 = User.create(name:'Devin', email:'devin@faker.net')
    @user2 = User.create(name:'Eric', email:'eric@faker.net')
    visit root_path
  end

  describe 'display' do
    it 'title of application' do
      expect(page).to have_content("Viewing Party")
    end

    it 'button to create a new user' do
      click_button 'Create a New User'
      expect(current_path).to eq('/register')
    end

    it 'list of existing users which link to the users dashboard' do
      click_on "#{@user1.email}'s Dashboard"
      expect(current_path).to eq(user_dashboard_path(@user1))

      visit root_path

      click_on "#{@user2.email}'s Dashboard"
      expect(current_path).to eq(user_dashboard_path(@user2))
    end

    it 'header link to go back to landing page' do
      click_on 'Home'
      expect(current_path).to eq('/')

      click_on "#{@user1.email}'s Dashboard"
      expect(current_path).to eq(user_dashboard_path(@user1))

      click_on 'Home'
      expect(current_path).to eq('/')
    end 
  end
end