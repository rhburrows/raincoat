Given /^I am in the temp directory$/ do
  $root ||= FileUtils.pwd
  unless File.exists?(File.join($root, "tmp"))
    FileUtils.mkdir(File.join($root, "tmp"))
  end
  FileUtils.chdir(File.join($root, "tmp"))
end

Given /^a new git project$/ do
  `git init`
  `git ci -m 'head commit' --allow-empty`
end

Given /^the "(.+)" directory is empty$/ do |dir|
  FileUtils.rm_r Dir.glob(File.join(dir, '*'))
  FileUtils.rm_r Dir.glob(File.join(dir, '.git'))
end

Given /^the directory is clean$/ do
  Given "the \"#{FileUtils.pwd}\" directory is empty"
end

Given /^I have staged changes in files:$/ do |table|
  table.hashes.each do |file|
    `echo 'change' > #{file['name']}`
    `git add #{file['name']}`
  end
end

Given /^I have one new empty file called "([^\"]*)" staged$/ do |file|
  `touch #{file}`
  `git add #{file}`
end
