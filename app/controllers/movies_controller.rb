class MoviesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @movies = if params[:search]
                MovieFacade.movie_search(params[:search])
              else
                MovieFacade.top_40_movies
              end
  end
end
