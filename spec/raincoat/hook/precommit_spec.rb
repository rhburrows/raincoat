require 'spec_helper'

module Raincoat
  module Hook
    describe Precommit do
      describe "#changes" do
        let(:git){ double("Git").as_null_object }
        let(:precommit){ Precommit.new("", git) }

        it "creates a new changes object with the git" do
          Changes.should_receive(:new).with(git)
          precommit.changes
        end

        it "returns the changes object" do
          changes = double("Changes")
          Changes.stub(:new).and_return(changes)
          precommit.changes.should == changes
        end
      end
    end
  end
end
