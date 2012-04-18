require 'spec_helper'

describe GitNetworkitis::CommitGetter do
  describe "#get" do
    it "should GET all of the commits since the specified date when since is a date string" do
      getter = GitNetworkitis::CommitGetter.new('url',
                                                access_token: 'token',
                                                since: '2012-04-11T09:52:27-07:00')
      getter.should_receive(:since_date_commits)
      getter.get
    end

    it "should GET all of the commits since the specified SHA when since is not a date" do
      getter = GitNetworkitis::CommitGetter.new('url',
                                                access_token: 'token',
                                                since: '1d444044117239f41e68f8ba6c815874fae3dc0e')
      getter.should_receive(:since_sha_commits)
      getter.get
    end

    it "should GET all of the commits using whatever other options are specified when no since value is supplied" do
      getter = GitNetworkitis::CommitGetter.new('url', access_token: 'token', batch: true)
      getter.stub! build_commits: ["the", "commits"]
      getter.should_receive(:batched_get)
      getter.get.should == ["the", "commits"]
    end
  end

end
