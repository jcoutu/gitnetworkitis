require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Gitnetworkitis::Branch" do
  let(:branch) { GitNetworkitis::Branch.new(@token) }
  let(:branches) { branch.find_all({:owner => "jcoutu", :repo => "gitnetworkitis"}) }

  context "#find_all" do
    it "should return a collection of branches for a specific repo" do
      VCR.use_cassette("all_branches") do
        branches.should_not be_empty
        branches.select {|b| b.name == "master" }.size.should == 1
        branches.select {|b| b.name == "spec-branch-1" }.size.should == 1
        branches.select {|b| b.name == "spec-branch-2" }.size.should == 1
        branches.select {|b| b.name == "spec-branch-3" }.size.should == 1
      end
    end
  end

  context "#commits" do
    attr_reader :spec_branch_1, :spec_branch_2, :spec_branch_3

    before :each do
      @spec_branch_1, @spec_branch_2, @spec_branch_3 = nil

      VCR.use_cassette("all_branches") do
        @spec_branch_1 = branches.detect {|b| b.name == "spec-branch-1" }
        @spec_branch_2 = branches.detect {|b| b.name == "spec-branch-2" }
        @spec_branch_3 = branches.detect {|b| b.name == "spec-branch-3" }
      end
    end

    it "should return an array of commits for the branch" do
      VCR.use_cassette("spec-branch-1_commits", :record => :new_episodes) do
        commits = spec_branch_1.commits(batch: true, per_page: 15)
        commits.length.should == 43
        commits.first.message.should == "modifies test file so that there's something to commit"
      end

      VCR.use_cassette("spec-branch-2_commits", :record => :new_episodes) do
        commits = spec_branch_2.commits(batch: false, per_page: 15)
        commits.length.should == 15
        commits.first.message.should == "adds otro test file"
      end

      VCR.use_cassette("spec-branch-3_commits") do
        commits = spec_branch_3.commits
        commits.length.should == 41
        commits.first.message.should == "adds VCR for saner handling of responses in specs, converts Base and Repository to Github API v3 and OAuth 2"
      end
    end

    it "should return only commits since a certain SHA if one is specified" do
      VCR.use_cassette("spec-branch-1_since_sha") do
        commits = spec_branch_1.commits(since: '8e6f9227f646bfe17d296cf418f2ba5ccdca4b48')
        commits.length.should == 2
        commits.first.message.should == "modifies test file so that there's something to commit"
        commits.last.message.should == "adds test file"
        commits.map(&:sha).should_not include("8e6f9227f646bfe17d296cf418f2ba5ccdca4b48")
      end
    end

    it "should return only commits since a certain date/time if one is specified" do
      pending
      VCR.use_cassette("spec-branch-1_since_date", :record => :all) do
        commits = spec_branch_1.commits(since: '2012-04-06T14:14:59-07:00')
        commits.length.should == 3
        commit_shas = commits.map(&:sha)
        commit_shas.should include('3d68c13854c8898f8817e2cc60757c41c72ec1de')
        commit_shas.should include('b1907bcca525cb5fcacaa492b828126d0c8cc91c')
        commit_shas.should include('8e6f9227f646bfe17d296cf418f2ba5ccdca4b48')
        commit_shas.should_not include('ce44c956380073a04ef28eee76b4dc0749d4fa6e')
      end
    end
  end

end
