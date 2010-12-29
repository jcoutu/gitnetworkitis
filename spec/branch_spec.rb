require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Gitnetworkitis::Branch" do

  before :each do
    fake_responses
  end

  context "find_all" do
    let(:branch){GitNetworkitis::Branch.new(@username, @token)}
    let(:test){branch.find_all({:owner=>"turingstudio", :repo => "loupe", :nethash => "068161e2c05a6b8029a7eb410dd27b1dfa531338"})}

    it "should return a collection of branches for a specific repo" do
      test.should_not be_empty
      test.first.name.should_not be_empty
      test.length.should == 3
    end
  end
  
  context "commits" do
    let(:branch){GitNetworkitis::Branch.new(@username, @token)}
    let(:test){branch.find_all({:owner=>"turingstudio", :repo => "loupe", :nethash => "068161e2c05a6b8029a7eb410dd27b1dfa531338"})}

    it "should return an array of commits for the branch" do
      test[0].commits.should_not be_empty
    end
    
  end
end