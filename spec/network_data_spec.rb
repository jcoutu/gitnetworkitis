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
      test.commits.length.should  == 134
    end

    it "should set the network_meta" do
      test.network_meta.should == network_meta
    end
  end  
  
  context "find with start set and no end" do
    let(:tester){GitNetworkitis::NetworkMeta.new(@username, @token)}
    let(:network_meta){tester.find({:owner=>"turingstudio", :repo => "loupe"})}
    let(:network_data){GitNetworkitis::NetworkData.new(@username, @token)}
    let(:test){network_data.find({:owner=>"turingstudio", :repo => "loupe", :network_meta => network_meta, :start => 130})}

    before :each do
      fake_responses
    end

    it "should set the commits array" do
      test.commits.should_not be_empty
      test.commits.first.parents.should_not be_empty
      test.commits.length.should  == 4
    end

    it "should set the network_meta" do
      test.network_meta.should == network_meta
    end
  end
  
  context "find with start and end set" do
    let(:tester){GitNetworkitis::NetworkMeta.new(@username, @token)}
    let(:network_meta){tester.find({:owner=>"turingstudio", :repo => "loupe"})}
    let(:network_data){GitNetworkitis::NetworkData.new(@username, @token)}
    let(:test){network_data.find({:owner=>"turingstudio", :repo => "loupe", :network_meta => network_meta, :start => 1, :end => 5})}

    before :each do
      fake_responses
    end

    it "should set the commits array" do
      test.commits.should_not be_empty
      test.commits.first.parents.should_not be_empty
      test.commits.length.should  == 5
    end

    it "should set the network_meta" do
      test.network_meta.should == network_meta
    end
  end
  
  context "find with no owner or repo" do
    let(:tester){GitNetworkitis::NetworkMeta.new(@username, @token)}
    let(:network_meta){tester.find({:owner=>"turingstudio", :repo => "loupe"})}
    let(:network_data){GitNetworkitis::NetworkData.new(@username, @token)}

    before :each do
      fake_responses
    end

    it "should raise exception" do
      lambda {network_data.find({:network_meta => network_meta, :start => 1, :end => 5})}.should raise_error
    end
  end
  
  
  context "find on repo with large amount of commits" do
    let(:tester){GitNetworkitis::NetworkMeta.new(@username, @token)}
    let(:network_meta){tester.find({:owner=>"turingstudio", :repo => "website-girlambition"})}
    let(:network_data){GitNetworkitis::NetworkData.new(@username, @token)}
    let(:test){network_data.find({:owner=>"turingstudio", :repo => "website-girlambition", :network_meta => network_meta})}

    before :each do
      fake_responses
    end

    it "should set the commits array" do
      test.commits.should_not be_empty
      test.commits.first.parents.should be_empty
      test.commits.length.should  == 5000
    end
  end
  
end