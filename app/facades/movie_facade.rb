class MovieFacade
  def top_40_movies
    #data = MovieService.top_movies(1).concat(MovieService.top_movies(2))
    service.top_movies.map do |movie_data|
      Movie.new(movie_data)
    end
  end

  def movie_search(search_param)
    #data = MovieService.search_movies(search_param, 1).concat(MovieService.search_movies(search_param, 2))
    service.search_movies(search_param).map do |movie_data|
      Movie.new(movie_data)
    end
  end

  def service
    MovieService.new
  end
end
