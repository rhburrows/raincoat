
module Raincoat
  module Hook
    class Precommit < Base
      attr_reader :git

      def initialize(hook_dir = "pre-commit", git = Git.new)
        super(hook_dir)
        @git = git
      end

      def changes
        return [self.get_diff, self.get_file_names]
      end

      def get_diff()
        return git.diff
      end

      def get_file_names()

        ary = []
         git.diff_index.split(/\n/).each do |file|
          file =~ /[MA]\s+([\w\/_\-\d\.]+)/
          ary.push($1.rstrip)
        end
        return ary
      end

    end
  end
end
