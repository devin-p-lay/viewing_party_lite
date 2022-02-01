require 'rails_helper'

describe 'register user' do
  before do
    visit '/register'
  end

  describe 'form to register' do
    it 'adds a new user' do
      fill_in 'Name', with: 'Elora'
      fill_in 'Email', with: 'elora@faker.net'
      click_on 'Register'
      new_user = User.last
      expect(current_path).to eq(user_dashboard_path(new_user))
    end
  end
end
