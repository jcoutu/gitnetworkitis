require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Gitnetworkitis::Repository" do

  before :each do
    fake_responses
  end
    

 it "should list a users watched repositories" do
   c = GitNetworkitis::Repository.new("jcoutu", "0ea98987469a2ef1daee5d1e30b42fd8")
   repos = c.find_all_watched() 
   repos.should_not be_empty
   repos.length.should == 15
 end

 it "should list a users repositories" do
   c = GitNetworkitis::Repository.new("jcoutu", "0ea98987469a2ef1daee5d1e30b42fd8")
   repos = c.find_all_owned() 
   repos.should_not be_empty
   repos.length.should == 1
 end

 it "should allow a user to search for a repo based on owner and repo name" do
   c = GitNetworkitis::Repository.new("jcoutu", "0ea98987469a2ef1daee5d1e30b42fd8")
   repo = c.find({:owner=>"turingstudio", :repo => "loupe"}) 
   repo.owner.should == "turingstudio"
 end
end