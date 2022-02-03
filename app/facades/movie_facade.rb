class MovieFacade
  def top_40_movies
    service.top_movies.map do |movie_data|
      Movie.new(movie_data)
    end
  end

  def movie_search(search_param)
    service.search_movies(search_param).map do |movie_data|
      Movie.new(movie_data)
    end
  end

  def service
    MovieService.new
  end
end
