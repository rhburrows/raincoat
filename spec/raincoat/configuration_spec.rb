require 'spec_helper'

module Raincoat
  describe Configuration do
    before do
      ENV["RAINCOAT_CONFIG"] = nil
    end

    it "reads the configuration file specified in ENV['RAINCOAT_CONFIG']" do
      ENV['RAINCOAT_CONFIG'] = "file.yml"
      Raincoat::Configuration.file.should == "file.yml"
    end

    it "defaults the configuration file to 'raincoat.yml'" do
      Raincoat::Configuration.file.should == "raincoat.yml"
    end

    describe "#new" do
      context "the configuration file doesn't exist" do
        before do
          File.stub!(:exists?).and_return(false)
        end
        
        it "defaults the script_dir to 'script'" do
          config = Configuration.new
          config.script_dir.should == 'script'
        end
      end

      context "the configuration file does exist" do
        before do
          File.stub!(:exists?).and_return(true)
          YAML.stub!(:load_file).and_return({ 'script_dir' => 'file_dir' })
        end

        it "reads the yaml file" do
          YAML.should_receive(:load_file)
          Configuration.new
        end

        it "uses the script_dir from the file" do
          config = Configuration.new
          config.script_dir.should == 'file_dir'
        end

        it "defaults the script_dir if its not in the file" do
          YAML.stub!(:load_file).and_return({ })
          config = Configuration.new
          config.script_dir.should == 'script'
        end
      end
    end
  end
end
