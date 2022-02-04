class MovieDetails
  attr_reader :id,
              :title,
              :vote_average,
              :runtime,
              :genres,
              :summary,
              :cast,
              :count_of_reviews,
              :review_author_details,
              :poster

  def initialize(data)
    @id = data[:id]
    @title = data[:title]
    @vote_average = data[:vote_average]
    @runtime = (data[:runtime])
    @genres = if data[:genres].nil?
      []
    else
      data[:genres].map {|genre| genre[:name]}
    end
    @summary = data[:overview]
    @cast = if data[:credits].nil?
      []
    else
      data[:credits][:cast][(1..10)]
    end
    @count_of_reviews = if data[:reviews].nil?
      []
    else
      data[:reviews][:total_results]
    end
    @review_author_details = if data[:reviews].nil?
      []
    else
      data[:reviews][:results].map {|author| author[:author_details]}
    end
    @poster = ''
  end

  def say_cheese(data)
    @poster = data[:poster_path]
  end

  def formatted_time
    "#{@runtime / 60} hr #{@runtime % 60} min"
  end
end
