require 'rails_helper'

describe 'register user' do
  before do
    @user2 = User.create(name:'Eric', email:'eric@faker.net')
    visit '/register'
  end

  describe 'form to register' do
    it 'adds a new user' do
      fill_in :name, with: 'Elora'
      fill_in :email, with: 'elora@faker.net'
      click_on 'Create New User'
      new_user = User.last
      expect(current_path).to eq("/users/#{new_user.id}/dashboard")
      expect(page).to have_content("Account Successfully Created!")
    end

    it 'cannot add because of duplicate email' do
      fill_in :name, with: 'Milk Man'
      fill_in :email, with: 'eric@faker.net'
      click_on 'Create New User'
      expect(current_path).to eq(register_path)
      expect(page).to have_content('Unable to register, please try again.')
    end

    it 'cannot add because form is filled out incorrectly' do
      fill_in :name, with: ''
      fill_in :email, with: ''
      click_on 'Create New User'
      expect(current_path).to eq(register_path)
      expect(page).to have_content('Unable to register, please try again.')
    end
  end
end
