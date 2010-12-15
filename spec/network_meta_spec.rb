require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Gitnetworkitis::NetworkMeta" do

  before :each do
    fake_responses
  end

  context "find" do
    let(:network_meta){GitNetworkitis::NetworkMeta.new(@username, @token)}

    before :each do
      fake_responses
    end

    it "should set the NetworkMeta's nethash" do
      test = network_meta.find
      test.nethash.should == "e6598cce6fa0d71a266dce9ed0c053f0efa016ae"
    end

    it "should set the NetworkMeta's date" do
      test = network_meta.find
      test.dates.should_not be_empty
      test.dates.first.should == "2010-10-08"
      test.dates.last.should == "2010-12-14"
    end
    
  end
end