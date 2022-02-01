require 'rails_helper'

describe 'register user' do
  before do
    @user2 = User.create(name:'Eric', email:'eric@faker.net')
    visit '/register'
  end

  describe 'form to register' do
    it 'adds a new user' do
      fill_in 'Name', with: 'Elora'
      fill_in 'Email', with: 'elora@faker.net'
      click_on 'Register'
      new_user = User.last
      expect(current_path).to eq(user_dashboard_path(new_user))
      expect(page).to have_content("Welcome to the Viewing Party!")
    end

    it 'cannot add because of duplicate email' do
      fill_in 'Name', with: 'Milk Man'
      fill_in 'Email', with: 'eric@faker.net'
      click_on 'Register'
      expect(current_path).to eq(register_path)
      expect(page).to have_content("Unable to Register New User")
    end

    it 'cannot add because form is filled out incorrectly' do
      fill_in 'Name', with: ''
      fill_in 'Email', with: ''
      click_on 'Register'
      expect(current_path).to eq(register_path)
      expect(page).to have_content("Unable to Register New User")
    end 
  end
end
