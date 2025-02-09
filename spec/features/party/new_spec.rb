require 'rails_helper'

describe 'new party' do
  VCR.use_cassette('tmdb_movie_details_new') do
    before do
      @perot = User.create(name: 'Jacques Perot', email: 'foundyouout@justtherighttime.net')
      @white = User.create(name: 'Mrs. White', email: 'ididit@kitchenwithpipe.net')
      @mustard = User.create(name: 'Colin L. Mustard', email: 'colonelspelledweird@loungewithrope.net')
      @scarlett = User.create(name: 'Miss Scarlett', email: 'redletter@studywithknife.net')

      movie = MovieFacade.new
      @movie = movie.find_film(278)
      visit "/users/#{@perot.id}/movies/#{@movie.first.id}/parties/new"
    end

    describe 'display' do
      it 'header', :vcr do
        expect(page).to have_content("Create a Movie Party for The Shawshank Redemption")
      end


      it 'link to discover page', :vcr do
        click_on 'Discover Page'
        expect(current_path).to eq("/users/#{@perot.id}/discover")
      end

      describe 'viewing party details form', :vcr do
        it 'shows details and i can select parameters, then button creates to user dashboard while inviting other users' do
          expect(page).to have_field('length', with: 142)
          fill_in 'length', with: '143'

          select('2022', from: '_date_1i')
          select('July', from: '_date_2i')
          select('5', from: '_date_3i')

          select('06 PM', from: '_start_time_4i')
          select('30', from: '_start_time_5i')

          within "#user-#{@white.id}" do
            check
          end

          within "#user-#{@mustard.id}" do
            check
          end

          click_on "Let's Go Party... Lite!"
          expect(current_path).to eq(user_dashboard_path(@perot))
        end

        it 'errors if the length is shorter than movie length' do
          expect(page).to have_field('length', with: 142)
          fill_in 'length', with: '141'

          select('2022', from: '_date_1i')
          select('July', from: '_date_2i')
          select('5', from: '_date_3i')

          select('06 PM', from: '_start_time_4i')
          select('30', from: '_start_time_5i')

          within "#user-#{@white.id}" do
            check
          end

          within "#user-#{@mustard.id}" do
            check
          end

          click_on "Let's Go Party... Lite!"
          expect(current_path).to eq("/users/#{@perot.id}/movies/#{@movie.first.id}/parties/new")
          expect(page).to have_content("Error: Party duration cannot be shorter than movie runtime")
        end
      end
    end
  end
end
