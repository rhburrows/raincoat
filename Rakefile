require 'rubygems'

begin
  gem 'jeweler'
  require 'jeweler'

  Jeweler::Tasks.new do |gem|
    gem.name = 'raincoat'
    gem.summary = 'A way to package git-hooks with your project'
    gem.description = gem.summary
    gem.email = 'rhburrows@gmail.com'
    gem.homepage = 'http://github.com/rhburrows/raincoat'
    gem.authors = [ 'Ryan Burrows' ]
  end

  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: gem install jeweler"
end

begin
  require 'spec/rake/spectask'
  Spec::Rake::SpecTask.new do |t|
    t.spec_files = FileList['spec/**/*_spec.rb']
  end
rescue LoadError
  task(:spec){ $stderr.puts "`gem install rspec` to run specs." }
end

task :default => :spec

begin
  require 'cucumber'
  require 'cucumber/rake/task'
  Cucumber::Rake::Task.new(:features) do |t|
    t.cucumber_opts = "features --format pretty"
  end
rescue LoadError
  task(:features){ $stderr.puts "`gem install cucumber` to run features." }
end

begin
  require 'yard'
  YARD::Rake::YardocTask.new do |t|
    t.files   = ['lib/**/*.rb']
    t.options = [ '--protected',
                  '--files', 'History.txt',
                  '--title', 'raincoat' ]
  end
rescue LoadError
  task(:yard){ $stderr.puts "`gem install yard` to build documentation." }
end
