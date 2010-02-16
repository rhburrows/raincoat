require 'fileutils'

class TestHook
  def initialize(hook)
    @tmp_file = File.join(FileUtils.pwd, "hook.#{rand(1000)}.tmp")
    @hook = hook
  end

  def run
    puts "WRITE #{@tmp_file}"
    FileUtils.touch(@tmp_file)
    @hook.run
  end

  def has_run?
    File.exists?(@tmp_file)
  end

  def method_missing(meth, *args, &block)
    @hook.send(meth, *args, &block)
  end
end
