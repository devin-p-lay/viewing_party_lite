require 'rails_helper'

describe 'welcome page' do
  before do
    @user1 = create :user
    @user2 = create :user
    visit root_path
  end

  describe 'display' do
    it 'title' do
      expect(page).to have_content 'Viewing Party'
    end

    it 'button to create a new user' do
      within '#create_user'
        click_button 'Create a New User'
        expect(current_path).to eq '/register'
      end
    end

    it 'link for user to login' do
      click_on 'Log In'
      expect(current_path).to eq '/login'
    end

    it 'header link to go back to landing page' do
      click_on 'Home'
      expect(current_path).to eq('/')

      click_on "Create a New User"
      expect(current_path).to eq('/register')

      click_on 'Home'
      expect(current_path).to eq('/')
    end

  xcontext 'as a user' do
    describe 'display' do
      it 'list of existing users' do
        within "#user-#{@user1.id}" do
          expect(page).to have_content "#{@user1.email}"
        end

        within "#user-#{@user2.id}" do
          expect(page).to have_content "#{@user2.email}"
        end
      end

      it 'link to logout' do
        expect(page).to have_content "#{@user1.email}"

        click_link 'Log Out'
        expect(current_path).to eq root_path
        expect(page).to_not have_content "#{@user1.email}"
      end
    end
  end
end