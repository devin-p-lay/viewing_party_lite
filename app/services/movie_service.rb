class MovieService
  class << self
    def top_movies(page_number)
      response = conn.get("/3/discover/movie?sort_by=popularity.desc&page=#{page_number}")
      body = parse_json(response)
      body[:results]
    end

    def search_movies(search_param, page_number)
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
end