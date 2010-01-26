When /^I write the configuration file:$/ do |string|
  File.open(CONFIG_FILE, "w") do |file|
    file.puts string
  end
end
