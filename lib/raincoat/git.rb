module Raincoat
  module Hook
    class Git

      def diff
        return execute('git diff --cached')
      end

      def  diff_index
        return  execute("git diff-index HEAD --cached")
      end

      def execute(cmd)
        `#{cmd}`
      end
    end
  end
end