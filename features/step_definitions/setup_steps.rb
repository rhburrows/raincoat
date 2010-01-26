Given /^I am in the temp directory$/ do
  $root ||= FileUtils.pwd
  unless File.exists?(File.join($root, "tmp"))
    FileUtils.mkdir(File.join($root, "tmp"))
  end
  FileUtils.chdir(File.join($root, "tmp"))
end

Given /^a new git project$/ do
  `git init`
end

Given /^the "(.+)" directory is empty$/ do |dir|
  FileUtils.rm_r Dir.glob(File.join(dir, '*'))
end

Given /^the directory is clean$/ do
  Given "the \"#{FileUtils.pwd}\" directory is empty"
end
