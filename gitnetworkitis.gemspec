# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "gitnetworkitis"
  s.version = "0.5.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Julian Coutu"]
  s.date = "2012-07-04"
  s.description = "Git API Gem utilizing the Network API"
  s.email = "jcoutu@phaseiiicreations.com"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    ".rspec",
    ".rvmrc",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "get_token.rb",
    "gitnetworkitis-0.1.0.gem",
    "gitnetworkitis.gemspec",
    "lib/gitnetworkitis.rb",
    "lib/gitnetworkitis/base.rb",
    "lib/gitnetworkitis/batch_response.rb",
    "lib/gitnetworkitis/branch.rb",
    "lib/gitnetworkitis/commit.rb",
    "lib/gitnetworkitis/commit_getter.rb",
    "lib/gitnetworkitis/getter.rb",
    "lib/gitnetworkitis/json_helper.rb",
    "lib/gitnetworkitis/repository.rb",
    "spec/base_spec.rb",
    "spec/branch_spec.rb",
    "spec/getter_spec.rb",
    "spec/github_config.yml.example",
    "spec/gitnetworkitis_spec.rb",
    "spec/repository_spec.rb",
    "spec/spec_helper.rb",
    "spec/support/vcr_setup.rb",
    "spec/vcr_cassettes/all_branches.json",
    "spec/vcr_cassettes/all_repos.json",
    "spec/vcr_cassettes/bad_creds.json",
    "spec/vcr_cassettes/find_repo.json",
    "spec/vcr_cassettes/spec-branch-1_commits.json",
    "spec/vcr_cassettes/spec-branch-1_since_date.json",
    "spec/vcr_cassettes/spec-branch-1_since_sha.json",
    "spec/vcr_cassettes/spec-branch-2_commits.json",
    "spec/vcr_cassettes/spec-branch-3_commits.json"
  ]
  s.homepage = "http://github.com/jcoutu/gitnetworkitis"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.15"
  s.summary = "Git API Gem utilizing the Network API"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<httparty>, [">= 0.8.1"])
      s.add_development_dependency(%q<rspec>, ["~> 2.8.0"])
      s.add_development_dependency(%q<bundler>, [">= 0"])
      s.add_development_dependency(%q<jeweler>, [">= 0"])
      s.add_development_dependency(%q<fakeweb>, [">= 0"])
      s.add_development_dependency(%q<vcr>, ["~> 2.0.1"])
    else
      s.add_dependency(%q<httparty>, [">= 0.8.1"])
      s.add_dependency(%q<rspec>, ["~> 2.8.0"])
      s.add_dependency(%q<bundler>, [">= 0"])
      s.add_dependency(%q<jeweler>, [">= 0"])
      s.add_dependency(%q<fakeweb>, [">= 0"])
      s.add_dependency(%q<vcr>, ["~> 2.0.1"])
    end
  else
    s.add_dependency(%q<httparty>, [">= 0.8.1"])
    s.add_dependency(%q<rspec>, ["~> 2.8.0"])
    s.add_dependency(%q<bundler>, [">= 0"])
    s.add_dependency(%q<jeweler>, [">= 0"])
    s.add_dependency(%q<fakeweb>, [">= 0"])
    s.add_dependency(%q<vcr>, ["~> 2.0.1"])
  end
end

