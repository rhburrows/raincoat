require 'erb'

module Raincoat
  class ScriptWriter
    GIT_HOOK_DIR = File.join(".git","hooks")

    def initialize(script_dir)
      @script_dir = script_dir
    end

    def write(hook_name)
      init_script_directory(File.join(@script_dir, hook_name))
      path = File.join(GIT_HOOK_DIR, hook_name)
      File.open(path, "w") do |f|
        f.puts(build_script(hook_name))
      end
      FileUtils.chmod 0777, path
    end

    def build_script(hook_name)
      hook_type = hook_name.sub(/-/, '')
      script_dir = File.join(@script_dir, hook_name)
      ERB.new(DEFAULT_TEMPLATE).result(binding)
    end

    private

    def init_script_directory(dir)
      unless File.directory? dir
        FileUtils.mkdir_p dir
      end
    end

    DEFAULT_TEMPLATE = <<TEMPLATE
#!/usr/bin/env ruby
require 'rubygems'
require 'raincoat'

class ActiveHook < Raincoat::Hook
  def git_diff
    Raincoat::DiffUtils.<%= hook_type %>_diff
  end
end

puts "RUNNING!"
exit(ActiveHook.new("<%= script_dir %>").run)

TEMPLATE
  end
end
