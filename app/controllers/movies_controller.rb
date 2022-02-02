class MoviesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    if params[:search]
      movie = MovieFacade.new
      @movie = movie.movie_search(params[:search])
    else
      @movie = MovieFacade.new
    end
  end
end
