require 'spec_helper'

describe GitNetworkitis::Getter do

  describe ".initialize" do
    it "should separate local options from query options" do
      getter = GitNetworkitis::Getter.new('url',
                                          access_token: "token",
                                          per_page: 100,
                                          batch: true,
                                          since: 'sha')
      getter.local_options.should == {batch: true, since: 'sha'}
      getter.query_options.should == {access_token: "token", per_page: 100}
    end
  end

  describe "#get" do
    it "should default the per_page option to 100" do

    end

    it "should perform a regular GET when no batch nor since options are set" do
      getter = GitNetworkitis::Getter.new('url', access_token: 'token')
      getter.should_receive(:single_get)
      getter.get
    end

    it "should perform a batched GET when batch is true and since isn't set" do
      getter = GitNetworkitis::Getter.new('url', access_token: 'token', batch: true)
      getter.should_receive(:batched_get)
      getter.get
    end
  end

end
