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
        writer.write("test-file", Raincoat::Hook::Precommit)
      end

      it "generates a script for the correct git hook" do
        writer.should_receive(:build_script).with(Raincoat::Hook::Precommit)
        writer.write("test-file", Raincoat::Hook::Precommit)
      end

      it "writes the result of #build_script to the file" do
        writer.stub!(:build_script).and_return("generated script!")
        file.should_receive(:puts).with("generated script!")
        writer.write("test-file", Raincoat::Hook::Precommit)
      end

      it "makes the script executable" do
        FileUtils.should_receive(:chmod).with(0777, ".git/hooks/test-file")
        writer.write("test-file", Raincoat::Hook::Precommit)
      end

      it "fails if git already has the hook" do
        File.stub!(:exists?).and_return(true)
        File.should_not_receive(:open)
        writer.write("test-file", Raincoat::Hook::Precommit)
      end
    end

    describe "#build_script" do
      it "instantiates and runs the hook" do
        script = writer.build_script(Raincoat::Hook::Precommit)
        script.should match(/Raincoat::Hook::Precommit\.new\.run/)
      end
    end
  end
end
