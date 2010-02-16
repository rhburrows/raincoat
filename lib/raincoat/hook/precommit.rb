module Raincoat
  module Hook
    class Precommit < Base
      def initialize(config_file, hook_dir = "precommit")
        super(config_file, hook_dir)
      end

      def git_diff
        Raincoat::DiffUtils.precommit_diff
      end
    end
  end
end
