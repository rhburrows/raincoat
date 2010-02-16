require 'spec_helper'

module Raincoat
  module Hook
    describe Precommit do
      let(:precommit){ Precommit.new("somefile") }

      describe "#git_diff" do
        it "asks the diff utils" do
          Raincoat::DiffUtils.should_receive(:precommit_diff)
          precommit.git_diff
        end
      end
    end
  end
end
