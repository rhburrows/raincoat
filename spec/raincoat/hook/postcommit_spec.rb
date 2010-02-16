require 'spec_helper'

module Raincoat
  module Hook
    describe Postcommit do
      let(:postcommit){ Postcommit.new("somefile") }

      describe "#git_diff" do
        it "asks the diff utils" do
          Raincoat::DiffUtils.should_receive(:postcommit_diff)
          postcommit.git_diff
        end
      end
    end
  end
end
