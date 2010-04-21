require 'fileutils'

class Whitespace
  def call(changes)
    changes.files.each  do |file|
      whole_text = ""
      File.open(file,"r").readlines.each do |line|
        whole_text += line.rstrip + "\n"
      end
      File.open(file, 'w') {|f| f.write(whole_text) }
    end
    true
  rescue
    false
  end
end
