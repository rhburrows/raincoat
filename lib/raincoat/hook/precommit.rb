module Raincoat
  module Hook
    class Precommit < Base
      def initialize(hook_dir = "pre-commit")
        super(hook_dir)
      end
    end
  end
end
