Given /^an existing hook$/ do
  @hook = Raincoat::Hook.new("tmp")
end

Given /^an empty hook directory$/ do
  FileUtils.rm Dir.glob(File.join(@hook.script_dir, "*.rb"))
end

When /^the hook is called$/ do
  @exit_status = @hook.run
end

Then /^the hook should exit with a 0 exit status$/ do
  @exit_status.should == 0
end
