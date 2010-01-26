module Raincoat
  # Installs the raincoat hooks into the .git directory of the current
  # project.
  #
  # @author Ryan Burrows
  class Installer
    # The list of currently supported hooks
    HOOKS = [ "pre-commit", "post-commit" ]

    # Create an installer that can install hooks to read the specified config
    # file.
    #
    # @param [String] config_file the path to the raincoat configuration file
    def initialize(config_file = nil)
      @config_file = config_file
    end
    
    # Install raincoat hooks in the current project for each of the supported
    # git-hook types. This will create the corresponding script directory if
    # it doesn't exist
    def install
      writer = ScriptWriter.new(@config_file)
      HOOKS.each do |hook|
        writer.write(hook)
      end
    end
  end
end
