module Raincoat
  class Installer
    HOOKS = [ "pre-commit", "post-commit" ]

    def initialize(script_dir)
      @script_dir = script_dir
    end
    
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
