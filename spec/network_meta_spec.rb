require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Gitnetworkitis::NetworkMeta" do
  context "find" do
    let(:network_meta){GitNetworkitis::NetworkMeta.new(@username, @token)}
    let(:test){network_meta.find({:owner=>"turingstudio", :repo => "loupe"})}

    before :each do
      fake_responses
    end

    it "should set the nethash" do
      test = network_meta.find({:owner=>"turingstudio", :repo => "loupe"})
      test.nethash.should == "26fb01d365a6f7ea57be92299803cae7b95ae25a"
    end

    it "should set the date array" do
      test.dates.should_not be_empty
      test.dates.first.should == "2010-10-08"
      test.dates.last.should == "2010-12-15"
    end

    it "should set focus" do
      test.focus.should == 109
    end

    it "should set the users array" do
      test.users.should_not == nil
      test.users.length.should == 1
      test.users[0]["repo"].should == "loupe"
      test.users[0]["heads"].length.should == 3
    end

    it "should set blocks" do
      test.blocks.should_not == nil
      test.blocks.length.should == 1
    end

    it "should set spacemap" do
      test.spacemap.should_not == nil
      test.spacemap.length.should == 3
    end
    
    it "should set branches to a collection of branches for a specific repo" do
      test.branches.should_not == nil
      test.branches.length.should == 3
    end
  end  
end