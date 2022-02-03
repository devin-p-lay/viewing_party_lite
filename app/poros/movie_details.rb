class MovieDetails
  attr_reader :id,
              :title,
              :vote_average,
              :runtime,
              :genres,
              :summary,
              :cast,
              :count_of_reviews,
              :review_author_details

  def initialize(data)
    @id = data[:id]
    @title = data[:title]
    @vote_average = data[:vote_average]
    @runtime = (data[:runtime]/60.0).to_s
    @genres = data[:genres].map {|genre| genre[:name]}
    @summary = data[:overview]
    @cast = data[:credits][:cast][(1..10)]
    @count_of_reviews = data[:reviews][:total_results]
    @review_author_details = data[:reviews][:results].map {|author| author[:author_details]}
  end
end
