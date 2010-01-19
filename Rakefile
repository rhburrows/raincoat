require 'rubygems'

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
