require 'spec_helper'

class ScriptOne; end
class ScriptTwo; end

module Raincoat
  module Hook
    describe Base do
      let(:hook){ Base.new('raincoat.yml', 'precommit') }

      describe "configuration" do
        context "the configuration file doesn't exist" do
          before do
            File.stub!(:exists?).and_return(false)
            @hook = Base.new("raincoat.yml", 'precommit')
          end

          it "defaults the script_dir to 'script'" do
            @hook.script_dir.should == 'script/precommit'
          end
        end

        context "the configuration file does exist" do
          before do
            File.stub!(:exists?).and_return(true)
            YAML.stub!(:load_file).and_return({ 'script_dir' => 'file_dir' })
          end

          it "reads the yaml file" do
            YAML.should_receive(:load_file)
            hook = Base.new('raincoat.yml', 'precommit')
          end

          it "uses the script_dir from the file" do
            hook = Base.new('raincoat.yml', 'precommit')
            hook.script_dir.should == 'file_dir/precommit'
          end

          it "defaults the script_dir if its not in the file" do
            YAML.stub!(:load_file).and_return({ })
            hook = Base.new('raincoat.yml', 'precommit')
            hook.script_dir.should == 'script/precommit'
          end
        end
      end

      describe "#run" do
        let(:script_one){ double("Script 1", :call => true) }
        let(:script_two){ double("Script 2", :call => true) }

        before(:each) do
          hook.stub!(:scripts).and_return([script_one, script_two])
          hook.stub!(:git_diff).and_return("diff")
        end

        it "generates a diff" do
          hook.should_receive(:git_diff)
          hook.run
        end

        it "calls #call on each script passing it the diff" do
          script_one.should_receive(:call).with("diff")
          script_two.should_receive(:call).with("diff")
          hook.run
        end

        it "doesn't short-circuit" do
          script_one.stub!(:call).and_return(1)
          script_two.should_receive(:call).with("diff")
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
