Given /^I have a Rakefile that requires the raincoat tasks$/ do
  File.open("Rakefile", "w") do |f|
    # We alter the load path because if Raincoat is installed it will need
    # to be in the load path
    f.puts "$LOAD_PATH << '../lib'"
    f.puts "require 'raincoat/rake/tasks'"
  end
end

Then /^it should list the tasks:$/ do |table|
  table.hashes.each do |task|
    @stdout.should include("rake #{task['name']}")
  end
end
