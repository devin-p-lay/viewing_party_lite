require 'rails_helper'

describe 'register user' do
  before do
    @user = create :user
    visit '/register'
  end

  describe 'form to register' do
    it 'adds a new user' do
      fill_in :name, with: 'Test'
      fill_in :email, with: 'test@faker.net'
      fill_in :password, with: 'password'
      fill_in :password_confirmation, with: 'password'
      click_on 'Create New User'
      new_user = User.last
      expect(current_path).to eq("/users/#{new_user.id}/dashboard")
      expect(page).to have_content("Account Successfully Created!")
    end

    it 'cannot add because of duplicate email' do
      fill_in :name, with: 'Test'
      fill_in :email, with: "#{@user.email}"
      click_on 'Create New User'
      expect(current_path).to eq(register_path)
      expect(page).to have_content('Email address is blank/already in use.')
    end

    it 'cannot add because form is filled out incorrectly' do
      fill_in :name, with: ''
      fill_in :email, with: ''
      click_on 'Create New User'
      expect(current_path).to eq(register_path)
      expect(page).to have_content('Email address is blank/already in use.')
    end
  end
end
