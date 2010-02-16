When /^I write the configuration file:$/ do |string|
  File.open(CONFIG_FILE, "w") do |file|
    file.puts string
  end
end

When /^the "([^\"]*)" environment variable is not set$/ do |var|
  ENV[var] = nil
end

When /^the "([^\"]*)" environment variable is "([^\"]*)"$/ do |var, value|
  ENV[var] = value
end

Then /^the configuration should be read from "([^\"]*)"$/ do |filename|
  Raincoat::Configuration.file.should == filename
end
