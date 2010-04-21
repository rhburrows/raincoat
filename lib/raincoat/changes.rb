module Raincoat
  class Changes
    attr_reader :raw, :files

    def initialize(git)
      @raw = git.diff
      @files = file_names_from_diff(git.diff_index)
    end

    private

    def file_names_from_diff(diff)
      diff.split(/\n/).inject([]) do |acc, file|
        file =~ /[MA]\s+([\w\/_\-\d\.]+)/
        acc + [$1.rstrip]
      end if diff
    end
  end
end
