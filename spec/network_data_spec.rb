require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Gitnetworkitis::NetworkData" do

  before :each do
    fake_responses
  end

  context "find" do
    let(:network_meta){GitNetworkitis::NetworkData.new(@username, @token)}
    let(:test){network_meta.find({:owner=>"turingstudio", :repo => "loupe", :nethash => "26fb01d365a6f7ea57be92299803cae7b95ae25a"})}

    before :each do
      fake_responses
      
    end

    it "should set the commits array" do
      test.commits.should_not be_empty
      test.commits.first.parents.should be_empty
      test.commits.first.login.should == "stephenjudkins"
    end
    
  end  
end