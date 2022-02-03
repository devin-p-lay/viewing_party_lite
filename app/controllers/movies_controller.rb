class MoviesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    movie = MovieFacade.new
    if params[:search] && params[:search].blank?
      []
    elsif params[:search]
      @movie = movie.movie_search(params[:search])
    else
      @movie= movie.top_40_movies
    end
  end

  def show
<<<<<<< HEAD
    @user = User.find(params[:user_id])
    movie = MovieFacade.new
    @movie = movie.find_film(params[:movie_id])
  end
=======
  end 
>>>>>>> e1740152cca8cecf94e585b7e2fe1dd3f462075f
end
