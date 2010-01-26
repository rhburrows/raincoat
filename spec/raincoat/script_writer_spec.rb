require 'spec_helper'

module Raincoat
  describe ScriptWriter do
    let(:writer){ ScriptWriter.new }

    before(:each) do
      $stderr = StringIO.new
    end

    describe "#write" do
      let(:file){ StringIO.new }

      before(:each) do
        File.stub!(:open).and_yield(file)
        FileUtils.stub!(:chmod)
        File.stub!(:directory?).and_return(true)
        FileUtils.stub!(:mkdir_p)
      end

      it "writes the script to the specified location" do
        File.should_receive(:open).with(".git/hooks/test-file", "w")
        writer.write("test-file")
      end

      it "generates a script for the correct git hook" do
        writer.should_receive(:build_script).with("test-file")
        writer.write("test-file")
      end

      it "writes the result of #build_script to the file" do
        writer.stub!(:build_script).and_return("generated script!")
        file.should_receive(:puts).with("generated script!")
        writer.write("test-file")
      end

      it "makes the script executable" do
        FileUtils.should_receive(:chmod).with(0777, ".git/hooks/test-file")
        writer.write("test-file")
      end

      it "fails if git already has the hook" do
        File.stub!(:exists?).and_return(true)
        File.should_not_receive(:open)
        writer.write("test-file")
      end
    end

    describe "#build_script" do
      it "substitutes the hook name to find the correct diff command" do
        script = writer.build_script("git-command")
        script.should include("Raincoat::DiffUtils.gitcommand_diff")
      end

      it "instantiates and runs the hook with the correct directory" do
        script = writer.build_script("git-command")
        script.should match(/ActiveHook\.new\(.+, ?"git-command"\)\.run/)
      end

      it "loads the config_file" do
        writer.config_file = "my-config.yml"
        script = writer.build_script("git-command")
        script.should match(/ActiveHook\.new\("my-config.yml", ".+"\)/)
      end

      it "defaults the config file to raincoat.yml" do
        script = writer.build_script("git-command")
        script.should match(/ActiveHook\.new\("raincoat.yml", ".+"\)/)
      end
    end
  end
end
