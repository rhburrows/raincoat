class DebugCheck
  def call(diff)
    diff.split(/^--- .+$/).inject(true) do |result, d|
      if d.match(/^\+.*debugger/)
        filename = d.match(/^\+\+\+ b\/(.+)$/)[1]
        puts "Found a debugger in file: #{filename}"
        puts d
        puts "\n"
        false
      else
        result
      end
    end
  end
end
