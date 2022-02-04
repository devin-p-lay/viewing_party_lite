require 'faraday'
require 'json'

class MovieService
  def top_movies
    response_1 = conn.get("/3/movie/top_rated?page=1")
    response_2 = conn.get("/3/movie/top_rated?page=2")
    body_1 = parse_json(response_1)
    body_2 = parse_json(response_2)
    conjunction_junction(body_1[:results], body_2[:results])
  end

  def search_movies(search_param)
    response_1 = conn.get("/3/search/movie?en-US&page=1&query=#{search_param}")
    response_2 = conn.get("/3/search/movie?en-US&page=2&query=#{search_param}")
    body_1 = parse_json(response_1)
    body_2 = parse_json(response_2)
    conjunction_junction(body_1[:results], body_2[:results])
  end

  def find_film(id)
    response = conn.get("/3/movie/#{id}?append_to_response=credits,reviews")
    body = [parse_json(response)]
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

    def conjunction_junction(function_1, function_2)
      function_1 + function_2
    end
end
