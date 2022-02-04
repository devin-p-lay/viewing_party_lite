require 'rails_helper'

RSpec.describe Movie do
  let!(:attributes) {{
    title: "This is a title",
    vote_average: 8.9,
    id: 123
    }}
  let!(:movie) {Movie.new(attributes)}

  it 'exists' do
    expect(movie).to be_a(Movie)
  end

  it 'has attributes' do
    expect(movie.title).to eq("This is a title")
    expect(movie.vote_average).to eq(8.9)
    expect(movie.id).to eq(123)
  end
end
