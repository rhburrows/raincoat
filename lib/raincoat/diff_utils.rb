module Raincoat
  class DiffUtils
    class << self
      def precommit_diff
        execute "git diff --cached"
      end

      def postcommit_diff
        execute "git diff HEAD^"
      end

      private

      def execute(cmd)
        `#{cmd}`
      end
    end
  end
end
