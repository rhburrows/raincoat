require 'rubygems'

begin
  require 'raincoat'
  require 'raincoat/rake/tasks'
rescue LoadError
  $stderr.puts "Missing raincoat. Raincoat tasks will be ignored"
end

spec = Gem::Specification.new do |s|
  s.name = 'raincoat'
  s.version = '0.2.2'
  s.platform = Gem::Platform::RUBY
  s.summary = 'Easily define git-hooks that can be passed with your project'
  s.description = s.summary
  s.author = 'Ryan Burrows'
  s.email = 'rhburrows@gmail.com'
  s.homepage = 'http://github.com/rhburrows/raincoat'
  s.require_path = 'lib'
  s.files = %w[LICENSE README.markdown Rakefile] + Dir.glob("{bin,lib}/**/*")
  s.bindir = 'bin'
  s.executables = ['raincoat']
end

spec_file = "#{spec.name}.gemspec"
desc "Create #{spec_file}"
file spec_file => "Rakefile" do
  File.open(spec_file, "w") do |file|
    file.puts spec.to_ruby
  end
end

begin
  require 'rake/gempackagetask'
rescue LoadError
  task(:gem){ $stderr.puts "`gem install rake` to package gems" }
else
  Rake::GemPackageTask.new(spec) do |pkg|
    pkg.gem_spec = spec
  end
  task :gem => spec_file
end

desc "install the gem locally"
task :install => :package do
  `gem install pkg/#{spec.name}-#{spec.version}`
end

begin
  require 'spec/rake/spectask'
  Spec::Rake::SpecTask.new do |t|
    t.spec_files = FileList['spec/**/*_spec.rb']
  end
rescue LoadError
  task(:spec){ $stderr.puts "`gem install rspec` to run specs." }
end

task :default => [:spec, :features]

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
