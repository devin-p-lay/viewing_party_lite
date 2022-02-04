require 'rails_helper'

RSpec.describe MovieDetails do
  let!(:attributes) {{
    id: 123,
    title: "This is a title",
    vote_average: 9.0,
    runtime: 123,
    genres: [{
      name: "this"
    }],
    overview: "this is a summary",
    credits: {cast: [1,2,3,4,5,6,7,8,9,10,11]},
    reviews: {total_results: 7, results: [{author_details: "Details"}]},
    poster_path: "gobbledeygook"
    }}

  let!(:movie) {MovieDetails.new(attributes)}
  it 'exists' do
    expect(movie).to be_a(MovieDetails)
  end

  it 'has attributes' do
    expect(movie.id).to eq(123)
    expect(movie.title).to eq("This is a title")
    expect(movie.vote_average).to eq(9.0)
    expect(movie.runtime).to eq(123)
    expect(movie.genres).to eq(["this"])
    expect(movie.summary).to eq("this is a summary")
    expect(movie.cast).to eq([2,3,4,5,6,7,8,9,10,11])
    expect(movie.count_of_reviews).to eq(7)
    expect(movie.review_author_details).to eq(["Details"])
    expect(movie.poster).to eq("gobbledeygook")
  end

  it 'can format time' do
    expect(movie.formatted_time).to eq("2 hr 3 min")
  end
end
