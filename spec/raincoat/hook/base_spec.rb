require 'spec_helper'

class ScriptOne; end
class ScriptTwo; end

module Raincoat
  module Hook
    describe Base do
      let(:hook){ Base.new('precommit') }

      describe "configuration" do
        it "creates a new configuration object when instantiated" do
          config = mock("config", :script_dir => '')
          Raincoat::Configuration.should_receive(:new).and_return(config)
          Base.new("hook")
        end
      end

      describe "#run" do
        let(:script_one){ double("Script 1", :call => true) }
        let(:script_two){ double("Script 2", :call => true) }

        before(:each) do
          hook.stub!(:scripts).and_return([script_one, script_two])
        end

        it "generates a representation of the git repository" do
          hook.should_receive(:changes)
          hook.run
        end

        it "calls #call on each script passing it the repository" do
          script_one.should_receive(:call).with("")
          script_two.should_receive(:call).with("")
          hook.run
        end

        it "doesn't short-circuit" do
          script_one.stub!(:call).and_return(1)
          script_two.should_receive(:call).with("")
          hook.run
        end
      end

      describe "#scripts" do
        let(:files){ ["script_one.rb", "script_two.rb"] }

        before(:each) do
          Dir.stub!(:glob).and_return(files)
          Kernel.stub!(:load)
        end

        it "gets a list of the ruby files in the script_dir" do
          Dir.should_receive(:glob).with("#{hook.script_dir}/*.rb")
          hook.scripts
        end

        it "loads each file into memory" do
          files.each do |f|
            Kernel.should_receive(:load).with(f)
          end
          hook.scripts
        end

        it "initializes a class based on the file name" do
          [ScriptOne, ScriptTwo].each do |s|
            s.should_receive(:new)
          end
          hook.scripts
        end

        it "returns the instaniated script objects" do
          scripts = [ScriptOne, ScriptTwo].map do |s|
            script = double(s.class.to_s)
            s.stub!(:new).and_return(script)
            script
          end
          hook.scripts.should == scripts
        end
      end
    end
  end
end
