module Raincoat
  # The superclass for the various hooks that are installed to be run by git.
  # subclasses of Hook should override git_diff to generate the correct diff
  # string so that it can be passed to the hook scripts.
  #
  # @author Ryan Burrows
  class Hook
    attr_reader :script_dir

    # Create a new hook object that will execute the scripts located in
    # script_dir
    #
    # @param [String] script_dir the path of the directory of scripts that
    #                 this hook executes
    def initialize(script_dir)
      @script_dir = script_dir
    end

    # This is called when the hook is executed by git's callbacks. It loads
    # each file in the script_dir and creates an instance of the defined class
    # call is then called on the instance being passed the result of git_diff.
    #
    # @return [Integer] the sum of the exit statuses of all executed scripts.
    #                   This number becomes the overall exit status of the hook.
    def run
      diff = git_diff.freeze
      success = scripts.inject(true) do |result, script|
        script.call(diff) && result
      end
      if success
        0
      else
        $stderr.puts "Operation unsuccessful!"
        $stderr.puts "One or more of your raincoat scripts failed"
        1
      end
    end

    # This loads all of the scripts in the script dir and instantiates the
    # objects.
    #
    # @return [Array] the list of newly created objects
    def scripts
      Dir.glob(File.join(script_dir, "*.rb")).inject([]) do |a, e|
        Kernel.load(e)
        a + [initialize_script(e)]
      end
    end

    # Should be overridden by subclass to express the diff between the two
    # git states that are being transitioned between.
    def git_diff
      ""
    end

    private

    def initialize_script(script_name)
      Object.const_get(class_name_for(script_name)).new
    end

    # Just like ActiveSupport's #classify
    def class_name_for(file_name)
      file_name.split(/\//).last.sub(/\.rb$/, '').split(/_/).map{ |s| s.capitalize }.join('')
    end
  end
end
