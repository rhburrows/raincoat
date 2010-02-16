require 'rake'
require File.join(File.dirname(__FILE__), '..', '..', 'raincoat')

namespace :raincoat do
  desc "Run this project's raincoat precommit scripts"
  task :precommit do
    Raincoat::Hook::Precommit.new.run
  end

  desc "Run this project's raincoat postcommit scripts"
  task :postcommit do
    Raincoat::Hook::Postcommit.new.run
  end
end
