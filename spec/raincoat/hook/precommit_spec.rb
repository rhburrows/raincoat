require 'spec_helper'

module Raincoat
  module Hook
    describe Precommit do
      let(:git) { Git.new }

      it "returns a list of files ready to commit" do
        precommit = Precommit.new("hook", git)
        git.stub!(:execute).and_return(":000000 100644 0000000000000000000000000000000000000000 6d44cc54577c7ab2e07586506c150fb93cb1000c A foo/blah.rb\n:000000 100644 0000000000000000000000000000000000000000 8b99fe917cfb0fa12784061be48b0d092fcc9a4f A  file.rb")
        precommit.get_file_names[0].should == "foo/blah.rb"
        precommit.get_file_names[1].should == "file.rb"
      end

      it "returns a diff" do
        precommit = Precommit.new("hook", git)
        string = <<-eos
diff --git a/blah.rb b/blah.rb
index 6d44cc5..9daeafb 100644
--- a/blah.rb
+++ b/blah.rb
@@ -1 +1 @@
-blaah
+test
eos
        git.stub!(:execute).and_return(string)
        precommit.get_diff.should == string
      end
    end
  end
end
