Given /^I am in the project directory$/ do
  @original_dir = FileUtils.pwd
  FileUtils.chdir PROJECT_DIR
end

When /^I install the scripts in the script directory$/ do
  Raincoat::Installer.new(SCRIPT_DIR).install
end

Then /^there should be a "([^\"]*)" hook$/ do |hook_name|
  File.exists?(File.join(".git", "hooks", hook_name)).should be_true
end

Then /^there should be a "([^\"]*)" script directory$/ do |hook_name|
  File.directory?(File.join(SCRIPT_DIR, hook_name)).should be_true
end

Then /^I change directories back$/ do
  FileUtils.chdir @original_dir
end
