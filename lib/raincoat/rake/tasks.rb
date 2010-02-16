require 'rake'
require File.join(File.dirname(__FILE__), '..', '..', 'raincoat')

namespace :raincoat do
  desc "Run this project's raincoat precommit scripts"
  task :precommit do
    Raincoat::Hook::Precommit.new(raincoat_config).run
  end

  desc "Run this project's raincoat postcommit scripts"
  task :postcommit do
    Raincoat::Hook::Postcommit.new(raincoat_config).run
  end

  def raincoat_config
    ENV['RAINCOAT_CONFIG'] || "raincoat.yml"
  end
end
