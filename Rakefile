begin
  require 'spec/rake/spectask'
  load 'tasks/rspec.rake'
rescue Exception => e
  raise "Cannot find rspec rake task. This is required to run the tests"
end

begin
  require 'cucumber'
  require 'cucumber/rake/task'
  load 'tasks/cucumber.rake'
rescue Exception => e
  raise "Cannot find cucumber. This is required to run the features"
end
