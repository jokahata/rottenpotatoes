Given /^the following movies exist:$/ do |table|
  table.map_headers!('title' => :title, 'rating' => :rating, 'director' => :director, 'release_date' => :release_date)
  @movies = table.hashes
end


