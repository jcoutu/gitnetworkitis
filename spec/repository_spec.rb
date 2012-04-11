require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Gitnetworkitis::Repository" do
  let(:repo) { GitNetworkitis::Repository.new(@token) }
  let(:test_repos) { @test_repos }

  context "#find_all" do
    #NOTE #find_all_watched and #find_all_owned swallowed the error and returned an empty
    # array instead. Should that happen here, instead?
    it "should fail if no credentials are found" do
      VCR.use_cassette("bad_creds") do
        repo = GitNetworkitis::Repository.new "bad creds"
        expect { repo.find_all }.to raise_error("Unable to find Github Repository")
      end
    end

    it "should find all repositories for the user by default" do
      VCR.use_cassette("all_repos") do
        repo_names = repo.find_all.map(&:name)
        test_repos.each {|tr| repo_names.should include(tr) }
      end
    end
  end

  context "#find" do
    it "should allow a user to search for a repo based on owner and repo name" do
      VCR.use_cassette("find_repo") do
        found_repo = repo.find({:owner=>"jcoutu", :repo => "gitnetworkitis"})
        found_repo.owner['login'].should == "jcoutu"
        found_repo.name.should == "gitnetworkitis"
      end
    end
  end

  context "#remote_id" do
    it "should set the remote_id to owner/name" do
      VCR.use_cassette("find_repo") do
        found_repo = repo.find({:owner=>"jcoutu", :repo => "gitnetworkitis"})
        found_repo.remote_id.should == "jcoutu/gitnetworkitis"
      end
    end
  end

end
