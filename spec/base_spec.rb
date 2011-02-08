require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Gitnetworkitis::Base" do

  context "#initialize" do
    it "should allow for username and token to be set on init" do
      c = GitNetworkitis::Base.new("jcoutu", "0ea98987469a2ef1daee5d1e30b42fd8")
      c.username.should == "jcoutu"
      c.token.should == "0ea98987469a2ef1daee5d1e30b42fd8"
    end
  end
  
  context "#get" do
    let(:base_class){GitNetworkitis::Base.new("jcoutu", "0ea98987469a2ef1daee5d1e30b42fd8")}
    let(:success_response){double(:response => double(:code=>"200"))}
    let(:failure_response){double(:response => double(:code=>"404"))}

    it "should return the response when successful" do
      base_class.class.should_receive(:get).and_return success_response
      t = base_class.get("http://google.com")
      t.should == success_response
    end

    it "should raise an exception when unsuccessful" do
      base_class.class.should_receive(:get).and_return failure_response
      lambda {base_class.get("http://google.com")}.should raise_error "Unable to find Github Repository"
    end

  end
  
  context "#parse_json" do
    
    let(:base_class){GitNetworkitis::Base.new("jcoutu", "0ea98987469a2ef1daee5d1e30b42fd8")}
    let(:success_response){double(:response => double(:code=>"200"))}
    let(:failure_response){double(:response => double(:code=>"404"))}

    it "should return the response when successful" do
      t = base_class.parse_json('{"test":"test"}')
      t["test"].should == "test"
    end

    it "should raise an exception when unsuccessful" do
      lambda {base_class.parse_json("http://google.com")}.should raise_error "Unable to parse JSON result"
    end
  end
end