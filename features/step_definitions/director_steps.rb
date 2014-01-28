Given /^the following movies exist:$/ do |table|
      Movie.create!(table.hashes)
 end


