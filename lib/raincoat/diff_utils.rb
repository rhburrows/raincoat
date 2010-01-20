module Raincoat
  # A set of utility methods that shell out to git to find changes that have
  # been made to the code. These changes can then be passed to the various
  # hook scripts that have been set up
  #
  # @author Ryan Burrows
  class DiffUtils
    class << self

      # Returns the diff between all staged changes and the current head
      #
      # @return [String] a string representation of the difference between
      #                  the staged changes and the head
      def precommit_diff
        execute "git diff --cached"
      end

      # Returns the diff between the current head and the previous head
      #
      # @return [String] a string representation of the difference between
      #                  the current head and the previous head
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
