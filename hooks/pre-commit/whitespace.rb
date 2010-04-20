require 'fileutils'
class Whitespace
  def call(x)
    file_names = x[1]
    file_names.each  do |file|
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
