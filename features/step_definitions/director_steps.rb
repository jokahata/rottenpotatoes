Given /^the following movies exist:$/ do |table|
    Movie.create(table.hashes)
 end

Then(/^the director of "(.*?)" should be "(.*?)"$/) do |arg1, arg2|
  @movie = Movie.find_by_title(arg1)
  @movie.director.should eq(arg2)
end


