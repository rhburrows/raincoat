begin
  require 'spec/rake/spectask'
  load 'tasks/rspec.rake'
rescue LoadError
  raise "Cannot find rspec rake task. This is required to run the tests"
end

begin
  require 'cucumber'
  require 'cucumber/rake/task'
  load 'tasks/cucumber.rake'
rescue LoadError
  raise "Cannot find cucumber. This is required to run the features"
end

begin
  require 'yard'
  load 'tasks/doc.rake'
rescue LoadError
  raise "Cannot find yard. This is required to build the documentation"
end
