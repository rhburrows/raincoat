begin
  require 'spec/rake/spectask'
  load 'tasks/rspec.rake'
rescue LoadError
  puts "Cannot find rspec rake task. This is required to run the tests"
end

begin
  require 'cucumber'
  require 'cucumber/rake/task'
  load 'tasks/cucumber.rake'
rescue LoadError
  puts "Cannot find cucumber. This is required to run the features"
end

begin
  require 'yard'
  load 'tasks/doc.rake'
rescue LoadError
  puts "Cannot find yard. This is required to build the documentation"
end
