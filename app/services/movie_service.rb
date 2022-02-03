require 'faraday'
require 'json'

class MovieService
  def top_movies
    response = conn.get("/3/movie/top_rated")
    body = parse_json(response)
    body[:results]
  end

  def search_movies(search_param)
    response = conn.get("/3/search/movie?en-US&page=#{page_number}&query=#{search_param}")
    body = parse_json(response)
    body[:results]
  end

  private
    def conn
      Faraday.new(url: "https://api.themoviedb.org") do |faraday|
        faraday.params['api_key'] = ENV['movie_api_key']
      end
    end

    def parse_json(response)
      JSON.parse(response.body, symbolize_names: true)
    end
end
