module Raincoat
  module Hook
    class Postcommit < Base
      def initialize(config_file, hook_dir = "postcommit")
        super(config_file, hook_dir)
      end

      def git_diff
        Raincoat::DiffUtils.postcommit_diff
      end
    end
  end
end
