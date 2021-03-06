CONFIG_FILE = "raincoat.yml"

Given /^an existing hook$/ do
  Given "an existing \"precommit\" hook"
end

Given /^an existing "precommit" hook$/ do
  @hook = Raincoat::Hook::Precommit.new
end

Given /^an empty hook directory$/ do
  unless File.exists?(@hook.script_dir)
    FileUtils.mkdir_p(@hook.script_dir)
  end
  FileUtils.rm Dir.glob(File.join(@hook.script_dir, "*.rb"))
end

Given /^a hook directory with:$/ do |script_table|
  script_table.hashes.each do |hash|
    script = Raincoat::Script.new(hash[:name], hash[:result] == "true")
    FileUtils.mkdir_p(@hook.script_dir) unless File.exists?(@hook.script_dir)
    File.open(File.join(@hook.script_dir, "#{hash[:name]}.rb"), 'w') do |f|
      f.puts(script.to_s)
    end
  end
end

When /^I create a "([^\"]*)" hook$/ do |hook_type|
  Given "an existing \"#{hook_type}\" hook"
end

When /^the hook is called$/ do
  @exit_status = @hook.run
end

Then /^the hook should exit with a (\d+) exit status$/ do |code|
  @exit_status.should == code.to_i
end

Then /^the hook should check for scripts in "([^\"]*)"$/ do |directory|
  @hook.script_dir.should == directory
end

Then /^the list of changed files should include "([^\"]*)"$/ do |file_name|
  @hook.changes.files.should include(file_name)
end

Then /^the raw changes should be:$/ do |diff|
  @hook.changes.raw.chomp.should == diff
end
