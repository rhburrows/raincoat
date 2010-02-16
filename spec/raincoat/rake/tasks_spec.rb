require 'spec_helper'
require 'rake'

describe "raincoat namespace" do
  let(:hook){ mock("hook").as_null_object }

  before do
    @rake = Rake::Application.new
    Rake.application = @rake
    load 'lib/raincoat/rake/tasks.rb'
  end

  describe "precommit task" do
    before do
      Raincoat::Hook::Precommit.stub!(:new).and_return(hook)
    end

    it "Creates a new precommit hook" do
      Raincoat::Hook::Precommit.should_receive(:new)
      run_task "raincoat:precommit"
    end

    it "Calls run on the precommit hook" do
      hook.should_receive(:run)
      run_task "raincoat:precommit"
    end
  end

  describe "postcommit task" do
    before do
      Raincoat::Hook::Postcommit.stub!(:new).and_return(hook)
    end

    it "Creates a new postcommit hook" do
      Raincoat::Hook::Postcommit.should_receive(:new)
      run_task "raincoat:postcommit"
    end

    it "Calls run on the postcommit hook" do
      hook.should_receive(:run)
      run_task "raincoat:postcommit"
    end
  end

  def run_task(name)
    @rake[name].invoke
  end

  after do
    Rake.application = nil
  end
end
