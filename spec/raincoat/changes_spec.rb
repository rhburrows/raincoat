require 'spec_helper'

module Raincoat
  describe Changes do
    describe "#initiailze" do
      let(:git){ double("Git").as_null_object }

      it "reads the diff from the git repo" do
        git.should_receive(:diff)
        Changes.new(git)
      end

      it "sets the raw diff" do
        git.stub(:diff).and_return("diff")
        Changes.new(git).raw.should == "diff"
      end

      it "reads the diff-index from the git repo" do
        git.should_receive(:diff_index)
        Changes.new(git)
      end

      DIFF_INDEX = <<-EOS
:000000 100644 0000000000000000000000000000000000000000 6d44cc54577c7ab2e07586506c150fb93cb1000c A foo/blah.rb
:000000 100644 0000000000000000000000000000000000000000 8b99fe917cfb0fa12784061be48b0d092fcc9a4f A  file.rb
      EOS

      it "sets the list of changed files" do
        git.stub(:diff_index).and_return(DIFF_INDEX)
        Changes.new(git).files.should == ['foo/blah.rb', 'file.rb']
      end
    end
  end
end
