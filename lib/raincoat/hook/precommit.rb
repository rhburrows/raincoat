
module Raincoat
  module Hook
    class Precommit < Base
      def initialize(hook_dir = "pre-commit", git = Git.new)
        super(hook_dir, git)
      end

      def changes
        @changes ||= Changes.new(git)
      end
    end
  end
end
