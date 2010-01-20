Given /^an existing hook$/ do
  @hook = Raincoat::Hook.new("tmp")
end

Given /^an empty hook directory$/ do
  FileUtils.rm Dir.glob(File.join(@hook.script_dir, "*.rb"))
end

Given /^a hook directory with:$/ do |script_table|
  script_table.hashes.each do |hash|
    script = Raincoat::Script.new(hash[:name], hash[:result] == "true")
    File.open(File.join(@hook.script_dir, "#{hash[:name]}.rb"), 'w') do |f|
      f.puts(script.to_s)
    end
  end
end

When /^the hook is called$/ do
  @exit_status = @hook.run
end

Then /^the hook should exit with a (\d+) exit status$/ do |code|
  @exit_status.should == code.to_i
end
