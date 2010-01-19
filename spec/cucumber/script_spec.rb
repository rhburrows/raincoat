require 'spec_helper'
require 'features/support/script'

module Raincoat
  describe Script do
    describe "#to_s" do
      before(:each) do
        @script = Script.new("test_script", false)
      end

      it "writes a class with the correct name" do
        eval(@script.to_s)
        lambda{ TestScript.new }.should_not raise_error
      end

      it "substitutes in the return value" do
        eval(@script.to_s)
        TestScript.new.call("diff").should be_false
      end
    end
  end
end
