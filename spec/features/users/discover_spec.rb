require 'rails_helper'

describe 'Discover Page', type: :feature do
  before do
    @user2 = User.create(name:'Eric', email:'eric@faker.net')
    visit user_discover_path(@user2)
  end

  describe 'display' do
    it 'Top Rated button' do
      VCR.use_cassette('tmdb_top_rated_movies') do
        click_button 'Top Rated Movies'
        expect(current_path).to eq(user_movies_path(@user2))
      end
    end

    xit 'form to search movies' do
      fill_in :search, with: 'Home'
      click_on 'Find Movies'
      expect(current_path).to eq(user_movies_path(@user2))
    end
  end
end
