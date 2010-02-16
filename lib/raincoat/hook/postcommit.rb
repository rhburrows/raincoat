module Raincoat
  module Hook
    class Postcommit < Base
      def initialize(hook_dir = "postcommit")
        super(hook_dir)
      end

      def git_diff
        Raincoat::DiffUtils.postcommit_diff
      end
    end
  end
end
