require 'spec_helper'

describe MoviesController do

  before(:each) do
    Movie.create!(title: "Transformers", director: "Michael Bay")
    Movie.create!(title: "Transformers 2", director: "Michael Bay")
  end

  it "likes pie" do
    expect(5).to eq(5)
    end
end
