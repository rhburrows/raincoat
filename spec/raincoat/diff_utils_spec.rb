require 'spec_helper'

module Raincoat
  describe DiffUtils do
    before(:each) do
      DiffUtils.stub!(:execute).and_return("diff")
    end

    describe "#precommit_diff" do
      it "calls git to get the difference" do
        DiffUtils.should_receive(:execute).with("git diff --cached")
        DiffUtils.precommit_diff
      end
      
      it "returns the result of the execute" do
        DiffUtils.precommit_diff.should == "diff"
      end
    end

    describe "#postcommit_diff" do
      it "calls git to get the difference" do
        DiffUtils.should_receive(:execute).with("git diff HEAD^")
        DiffUtils.postcommit_diff
      end
      
      it "returns the result of the execute" do
        DiffUtils.postcommit_diff.should == "diff"
      end
    end
  end
end
