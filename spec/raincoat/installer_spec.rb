require 'spec_helper'

module Raincoat
  describe Installer do
    describe "#install" do
      before(:each) do
        @installer = Installer.new("scripts")
        @writer = double("Script Writer", :write => false)
        ScriptWriter.stub!(:new).and_return(@writer)
        File.stub!(:directory?).and_return(true)
      end

      it "creates a script writer for the script directory" do
        ScriptWriter.should_receive(:new).with("scripts")
        @installer.install
      end

      it "creates the script directory if it doesn't exist" do
        File.stub!(:directory?).and_return(false)
        FileUtils.should_receive(:mkdir_p).with("scripts")
        @installer.install
      end

      it "doesn't create the script directory if it already exists" do
        FileUtils.should_not_receive(:mkdir_p)
        @installer.install
      end

      context "pre-commit" do
        it "writes the script to .git/hooks/pre-commit" do
          @writer.should_receive(:write).with("pre-commit")
          @installer.install
        end
      end

      context "post-commit" do
        it "writes the script to post-commit" do
          @writer.should_receive(:write).with("post-commit")
          @installer.install
        end
      end
    end
  end
end
