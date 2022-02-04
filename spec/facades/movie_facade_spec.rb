require 'rails_helper'

RSpec.describe MovieFacade do
  it '.top_40_movies', :vcr do
    movie = MovieFacade.new
    this_movie = movie.top_40_movies

    expect(this_movie).to be_a(Array)
    this_movie.each do |film|
      expect(film).to be_a(Movie)
    end
  end

  it '.movie_search', :vcr do
    movie = MovieFacade.new
    this_movie = movie.movie_search("shawshank")

    expect(this_movie).to be_a(Array)
    this_movie.each do |film|
      expect(film).to be_a(Movie)
    end
  end

  it '.find_film', :vcr do
    movie = MovieFacade.new
    this_movie = movie.find_film(238)

    expect(this_movie).to be_a(Array)
    this_movie.each do |film|
      expect(film).to be_a(MovieDetails)
    end
  end

  it '::find_film', :vcr do
    movie = MovieFacade.find_film(238)

    expect(movie).to be_a(Array)
    movie.each do |film|
      expect(film).to be_a(MovieDetails)
    end
  end
 end
