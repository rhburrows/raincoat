module Raincoat
  module Hook
    class Postcommit < Base
      def initialize(hook_dir = "post-commit")
        super(hook_dir)
      end
    end
  end
end
