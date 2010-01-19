PROJECT_DIR = "tmp"
SCRIPT_DIR = "scripts"

Given /^a clean script directory$/ do
  clean_dir(File.join(PROJECT_DIR, SCRIPT_DIR))
end

Given /^a clean project directory$/ do
  clean_dir(PROJECT_DIR)
end

Given /^a new git project$/ do
  original_dir = FileUtils.pwd
  FileUtils.chdir(PROJECT_DIR)
  `git init`
  FileUtils.chdir(original_dir)
end

def clean_dir(directory)
  FileUtils.remove_dir(directory) unless !File.directory? directory
  FileUtils.mkdir_p(directory)
end
