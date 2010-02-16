When /^I run "([^\"]*)"$/ do |cmd|
  @stdout = `#{cmd}`
end
