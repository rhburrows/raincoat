module Raincoat
  # Installs the raincoat hooks into the .git directory of the current
  # project.
  #
  # @author Ryan Burrows
  class Installer
    # The list of currently supported hooks
    HOOKS = [ "pre-commit", "post-commit" ]

    # Create an installer that watches scripts contained within script_dir
    #
    # @param [String] script_dir the path to the directory where the various
    #                 scripts that raincoat will run are put.
    def initialize(script_dir)
      @script_dir = script_dir
    end
    
    # Install raincoat hooks in the current project for each of the supported
    # git-hook types. This will create the corresponding script directory if
    # it doesn't exist
    def install
      unless File.directory?(@script_dir)
        FileUtils.mkdir_p(@script_dir)
      end

      writer = ScriptWriter.new(@script_dir)
      HOOKS.each do |hook|
        writer.write(hook)
      end
    end
  end
end
