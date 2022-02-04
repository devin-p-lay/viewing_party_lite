require 'rails_helper'

RSpec.describe MovieService do
  context 'class methods' do
    context ".top_movies" do
      it 'returns movie data' do
        VCR.use_cassette('tmdb_top_rated_movies_1&2') do
          movie = MovieService.new
          movies = movie.top_movies

          expect(movies).to be_a(Array)
          movie_data = movies.first

          expect(movie_data).to have_key(:title)
          expect(movie_data[:title]).to be_a(String)

          expect(movie_data).to have_key(:vote_average)
          expect(movie_data[:vote_average]).to be_a(Float)

          expect(movie_data).to have_key(:id)
          expect(movie_data[:id]).to be_a(Integer)
        end
      end
    end

    describe '.find_film' do
      it 'returns one movie by id' do
        VCR.use_cassette('tmdb_movie_details_with_credits_reviews') do
          movie = MovieFacade.new
          movie.find_film(278)
          expect(movie.find_film(278).first.id).to eq(278)
        end
      end
    end
  end
end
