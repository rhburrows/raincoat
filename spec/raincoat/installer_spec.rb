require 'spec_helper'

module Raincoat
  describe Installer do
    describe "#install" do
      before(:each) do
        @installer = Installer.new
        @writer = double("Script Writer", :write => false)
        ScriptWriter.stub!(:new).and_return(@writer)
        File.stub!(:directory?).and_return(true)
      end

      it "creates a script writer for the config file" do
        ScriptWriter.should_receive(:new)
        @installer.install
      end

      context "pre-commit" do
        it "writes the script to .git/hooks/pre-commit" do
          @writer.should_receive(:write).with("pre-commit",
                                              Raincoat::Hook::Precommit)
          @installer.install
        end
      end

      context "post-commit" do
        it "writes the script to post-commit" do
          @writer.should_receive(:write).with("post-commit",
                                              Raincoat::Hook::Postcommit)
          @installer.install
        end
      end
    end
  end
end
