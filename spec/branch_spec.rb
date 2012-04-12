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
    it "should return an array of commits for the branch" do
      spec_branch_1, spec_branch_2, spec_branch_3 = nil

      VCR.use_cassette("all_branches") do
        spec_branch_1 = branches.detect {|b| b.name == "spec-branch-1" }
        spec_branch_2 = branches.detect {|b| b.name == "spec-branch-2" }
        spec_branch_3 = branches.detect {|b| b.name == "spec-branch-3" }
      end

      VCR.use_cassette("spec-branch-1_commits") do
        commits = spec_branch_1.commits
        commits.length.should == 43
        commits.first.message.should == "modifies test file so that there's something to commit"
      end

      VCR.use_cassette("spec-branch-2_commits") do
        commits = spec_branch_2.commits
        commits.length.should == 42
        commits.first.message.should == "adds otro test file"
      end

      VCR.use_cassette("spec-branch-3_commits") do
        commits = spec_branch_3.commits
        commits.length.should == 41
        commits.first.message.should == "adds VCR for saner handling of responses in specs, converts Base and Repository to Github API v3 and OAuth 2"
      end
    end

  end
end
