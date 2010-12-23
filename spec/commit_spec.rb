require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Gitnetworkitis::Commit" do

  before :each do
    fake_responses
  end

  context "branch" do
     let(:tester){GitNetworkitis::NetworkMeta.new(@username, @token)}
      let(:network_meta){tester.find({:owner=>"turingstudio", :repo => "loupe"})}
    let(:network_data){GitNetworkitis::NetworkData.new(@username, @token)}
    let(:test){network_data.find({:owner=>"turingstudio", :repo => "loupe", :network_meta => network_meta})}

    it "should set the commits branch to correct name for the 'master' branch" do
      test.commits.should_not be_empty
      test.commits.first.branch.name.should == "master"
    end
    
    it "should set the commits branch to correct name for the 'git_network_api' branch" do
      test.commits.should_not be_empty
      test.commits.last.parents.should_not be_empty
      test.commits.last.branch.name.should == "git_network_api"
      test.commits.each do |commit|
          puts commit.parents.inspect
      end
    end
  end
end