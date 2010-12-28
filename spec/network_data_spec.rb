require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Gitnetworkitis::NetworkData" do

  before :each do
    fake_responses
  end

  context "find" do
    let(:tester){GitNetworkitis::NetworkMeta.new(@username, @token)}
    let(:network_meta){tester.find({:owner=>"turingstudio", :repo => "loupe"})}
    let(:network_data){GitNetworkitis::NetworkData.new(@username, @token)}
    let(:test){network_data.find({:owner=>"turingstudio", :repo => "loupe", :network_meta => network_meta})}

    before :each do
      fake_responses
    end

    it "should set the commits array" do
      test.commits.should_not be_empty
      test.commits.first.parents.should be_empty
      test.commits.first.login.should == "stephenjudkins"
    end

    it "should set the network_meta" do
      test.network_meta.should == network_meta
    end
  end  
end