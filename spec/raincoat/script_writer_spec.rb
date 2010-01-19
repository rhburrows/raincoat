require 'spec_helper'

module Raincoat
  describe ScriptWriter do
    before(:each) do
      @writer = ScriptWriter.new("test")
    end

    describe "#write" do
      before(:each) do
        @file = StringIO.new
        File.stub!(:open).and_yield(@file)
        FileUtils.stub!(:chmod)
        File.stub!(:directory?).and_return(true)
        FileUtils.stub!(:mkdir_p)
      end

      it "writes the script to the specified location" do
        File.should_receive(:open).with(".git/hooks/test-file", "w")
        @writer.write("test-file")
      end

      it "generates a script for the correct git hook" do
        @writer.should_receive(:build_script).with("test-file")
        @writer.write("test-file")
      end

      it "writes the result of #build_script to the file" do
        @writer.stub!(:build_script).and_return("generated script!")
        @file.should_receive(:puts).with("generated script!")
        @writer.write("test-file")
      end

      it "makes the script executable" do
        FileUtils.should_receive(:chmod).with(0777, ".git/hooks/test-file")
        @writer.write("test-file")
      end

      it "creates the script directory if it doesn't exist" do
        File.stub!(:directory?).and_return(false)
        FileUtils.should_receive(:mkdir_p).with("test/test-file")
        @writer.write("test-file")
      end

      it "doesn't create the script directory if it already exists" do
        File.stub!(:directory?).and_return(true)
        FileUtils.should_not_receive(:mkdir_p)
        @writer.write("test-file")
      end
    end

    describe "#build_script" do
      it "substitutes the hook name to find the correct diff command" do
        script = @writer.build_script("git-command")
        script.should include("Raincoat::DiffUtils.gitcommand_diff")
      end

      it "instantiates and runs the hook with the correct directory" do
        script = @writer.build_script("git-command")
        script.should include("ActiveHook.new(\"test/git-command\").run")
      end
    end
  end
end
