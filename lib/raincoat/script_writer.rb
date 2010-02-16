require 'erb'

module Raincoat
  # This class generates and writes out the actual git-hook files into the
  # project's .git directory.
  #
  # @author Ryan Burrows
  class ScriptWriter

    # The directory where git stores it's hooks
    GIT_HOOK_DIR = File.join(".git","hooks")

    # The raincoat configuration file
    attr_writer :config_file

    # Create a new ScriptWriter that creates hooks for the specified config_file
    # If no config file is specified it will use the default of 'raincoat.yml'
    #
    # @param [String] config_file the location of the configuration file
    def initialize(config_file = nil)
      @config_file = config_file || 'raincoat.yml'
    end

    # Write a new hook to the git directory called hook_name. Also, if there
    # isn't a corresponding 'hook_name' directory in the script_dir it will
    # be created.
    #
    # @param [String] hook_name the name of the git-hook to write this file for
    def write(hook_name)
      path = File.join(GIT_HOOK_DIR, hook_name)
      
      if File.exists?(path)
        $stderr.puts "#{path} already exists. Please delete it and re-run the installation."
        return
      end

      File.open(path, "w") do |f|
        f.puts(build_script(hook_name))
      end
      FileUtils.chmod 0777, path
    end

    # Generate the script that is going to be written in the git-hook file.
    #
    # @param [String] hook_name the name of the git-hook to build a script for
    def build_script(hook_name)
      hook_type = hook_name.sub(/-/, '')
      ERB.new(DEFAULT_TEMPLATE).result(binding)
    end

    DEFAULT_TEMPLATE = <<TEMPLATE
#!/usr/bin/env ruby
require 'rubygems'
require 'raincoat'

class ActiveHook < Raincoat::Hook::Base
  def git_diff
    Raincoat::DiffUtils.<%= hook_type %>_diff
  end
end

exit(ActiveHook.new("<%= @config_file %>", "<%= hook_name %>").run)

TEMPLATE
  end
end
