module Raincoat
  module Hook
    class Precommit < Base
      def initialize(hook_dir = "precommit")
        super(hook_dir)
      end

      def git_diff
        Raincoat::DiffUtils.precommit_diff
      end
    end
  end
end
