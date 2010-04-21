module Raincoat
  class Git
    def diff
      execute('git diff --cached')
    end

    def  diff_index
      execute("git diff-index HEAD --cached")
    end

    def execute(cmd)
      `#{cmd}`
    end
  end
end
