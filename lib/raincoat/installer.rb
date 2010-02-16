module Raincoat
  # Installs the raincoat hooks into the .git directory of the current
  # project.
  #
  # @author Ryan Burrows
  class Installer

    HOOKS = {
      "pre-commit"  => Raincoat::Hook::Precommit,
      "post-commit" => Raincoat::Hook::Postcommit
    }
    
    # Install raincoat hooks in the current project for each of the supported
    # git-hook types. This will create the corresponding script directory if
    # it doesn't exist
    def install
      writer = ScriptWriter.new
      HOOKS.each do |(hook_name, hook_type)|
        writer.write(hook_name, hook_type)
      end
    end
  end
end
