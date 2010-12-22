require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Gitnetworkitis::Branch" do

  before :each do
    fake_responses
  end

  context "find_all" do
    let(:branches){GitNetworkitis::Branch.new(@username, @token)}
    let(:test){branches.find_all({:owner=>"turingstudio", :repo => "loupe", :nethash => "26fb01d365a6f7ea57be92299803cae7b95ae25a"})}

    it "should return a collection of branches for a specific repo" do
      test.should_not be_empty
      test.first.name.should_not be_empty
      test.length.should == 3
    end
  end
end