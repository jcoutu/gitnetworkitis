require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Gitnetworkitis::Base" do
 it "should allow for username and token to be set on init" do
   c = GitNetworkitis::Base.new("jcoutu", "0ea98987469a2ef1daee5d1e30b42fd8")
   c.username.should == "jcoutu"
   c.token.should == "0ea98987469a2ef1daee5d1e30b42fd8"
 end
end