module Raincoat
  class Hook
    attr_reader :script_dir

    def initialize(script_dir)
      @script_dir = script_dir
    end

    def run
      diff = git_diff.freeze
      scripts.inject(true) do |result, script|
        script.execute(diff) && result
      end ? 0 : 1
    end

    def scripts
      Dir.glob(File.join(script_dir, "*.rb")).inject([]) do |a, e|
        Kernel.load(e)
        a + [initialize_script(e)]
      end
    end

    def git_diff
      ""
    end

    private

    def initialize_script(script_name)
      Object.const_get(class_name_for(script_name)).new
    end

    # Just like ActiveSupport's #classify
    def class_name_for(file_name)
      file_name.sub(/\.rb$/, '').split(/_/).map{ |s| s.capitalize }.join('')
    end
  end
end
