# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{raincoat}
  s.version = "0.2.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ryan Burrows"]
  s.date = %q{2010-03-08}
  s.default_executable = %q{raincoat}
  s.description = %q{Easily define git-hooks that can be passed with your project}
  s.email = %q{rhburrows@gmail.com}
  s.executables = ["raincoat"]
  s.files = ["LICENSE", "README.markdown", "Rakefile", "bin/raincoat", "lib/raincoat/configuration.rb", "lib/raincoat/hook/base.rb", "lib/raincoat/hook/postcommit.rb", "lib/raincoat/hook/precommit.rb", "lib/raincoat/hook.rb", "lib/raincoat/installer.rb", "lib/raincoat/rake/tasks.rb", "lib/raincoat/script_writer.rb", "lib/raincoat.rb"]
  s.homepage = %q{http://github.com/rhburrows/raincoat}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Easily define git-hooks that can be passed with your project}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
