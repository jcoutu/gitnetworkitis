require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Gitnetworkitis::Repository" do

  before :each do
    fake_responses
  end

  context "#find_all_watched" do
    it "should return an empty array if no credentials are found" do
      c = GitNetworkitis::Repository.new(nil, nil)
      repos = c.find_all_watched 
      repos.length.should == 0
    end

    it "should list a users watched repositories" do
      c = GitNetworkitis::Repository.new(@username, @token)
      repos = c.find_all_watched 
      repos.should_not be_empty
      repos.length.should == 15
    end
  end

  context "#find_all_owned" do
    it "should return an empty array if no credentials are found" do
      c = GitNetworkitis::Repository.new(nil, nil)
      repos = c.find_all_owned 
      repos.length.should == 0
    end

    it "should list a users repositories" do
      c = GitNetworkitis::Repository.new(@username, @token)
      repos = c.find_all_owned
      repos.should_not be_empty
      repos.length.should == 1
    end
  end

  context "#find" do
    it "should allow a user to search for a repo based on owner and repo name" do
      c = GitNetworkitis::Repository.new(@username, @token)
      repo = c.find({:owner=>"turingstudio", :repo => "loupe"}) 
      repo.owner.should == "turingstudio"
    end
  end
  
  context "#remote_id" do
    it "should set the remote_id to owner/name" do
      c = GitNetworkitis::Repository.new(@username, @token)
      repo = c.find({:owner=>"turingstudio", :repo => "loupe"}) 
      repo.remote_id.should == "turingstudio/loupe"
    end
    
  end

end