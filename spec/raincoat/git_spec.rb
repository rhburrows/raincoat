require 'spec_helper'

module Raincoat
  describe Git do
    describe "#diff" do
      it "Gets the difference between the head and the cache" do
        subject.should_receive(:execute).with("git diff --cached")
        subject.diff
      end

      it "returns the result" do
        subject.stub(:execute).and_return("result")
        subject.diff.should == "result"
      end
    end

    describe "#diff_index" do
      it "Does a diff-index against the cache" do
        subject.should_receive(:execute).with("git diff-index HEAD --cached")
        subject.diff_index
      end

      it "returns the result" do
        subject.stub(:execute).and_return("result")
        subject.diff_index.should == "result"
      end
    end
  end
end
