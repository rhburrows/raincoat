When /^I install the scripts in the script directory$/ do
  Raincoat::Installer.new.install
end

Then /^there should be a "([^\"]*)" hook$/ do |hook_name|
  File.exists?(File.join(".git", "hooks", hook_name)).should be_true
end
