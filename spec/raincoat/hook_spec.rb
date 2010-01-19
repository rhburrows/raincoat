require 'spec_helper'

class ScriptOne; end
class ScriptTwo; end

module Raincoat
  describe Hook do
    before(:each) do
      @hook = Hook.new("tmp")
    end

    it "knows the directory that the scripts it runs are in" do
      @hook.script_dir.should == "tmp"
    end

    describe "#run" do
      before(:each) do
        @script_one = double("Script 1", :execute => true)
        @script_two = double("Script 2", :execute => true)
        @hook.stub!(:scripts).and_return([@script_one, @script_two])
        @hook.stub!(:git_diff).and_return("diff")
      end

      it "generates a diff" do
        @hook.should_receive(:git_diff)
        @hook.run
      end

      it "calls execute on each script passing it the diff" do
        @script_one.should_receive(:execute).with("diff")
        @script_two.should_receive(:execute).with("diff")
        @hook.run
      end

      it "doesn't short-circuit" do
        @script_one.stub!(:execute).and_return(false)
        @script_two.should_receive(:execute).with("diff")
        @hook.run
      end
    end

    describe "#scripts" do
      before(:each) do
        @files = ["script_one.rb", "script_two.rb"]
        Dir.stub!(:glob).and_return(@files)
        Kernel.stub!(:load)
      end

      it "gets a list of the ruby files in the script_dir" do
        Dir.should_receive(:glob).with("tmp/*.rb")
        @hook.scripts
      end

      it "loads each file into memory" do
        @files.each do |f|
          Kernel.should_receive(:load).with(f)
        end
        @hook.scripts
      end

      it "initializes a class based on the file name" do
        [ScriptOne, ScriptTwo].each do |s|
          s.should_receive(:new)
        end
        @hook.scripts
      end

      it "returns the instaniated script objects" do
        scripts = [ScriptOne, ScriptTwo].map do |s|
          script = double(s.class.to_s)
          s.stub!(:new).and_return(script)
          script
        end
        @hook.scripts.should == scripts
      end
    end
  end
end
