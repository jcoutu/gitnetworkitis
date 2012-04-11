$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'gitnetworkitis'
require 'fakeweb'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  config.before(:each) {
    #Github OAuth 2 Access Token
    github_config = YAML.load_file(File.join(File.dirname(__FILE__), "github_config.yml"))
    @token, @test_repos = github_config['access_token'], github_config['test_repos']

    #This will tell the tests to use fakeweb responses or not. Removing this will mostly likely cause test failures
    @fake_web_requests = true
  }
end


def response_file(*path)
  File.join(File.dirname(__FILE__), "responses", path)
end

def fake_responses
  if @fake_web_requests
    FakeWeb.allow_net_connect = true
    FakeWeb.clean_registry
    auth = "#{@username}%2Ftoken:#{@token}@"
    FakeWeb.register_uri(:get, "https://#{auth}github.com/api/v2/json/repos/watched/jcoutu", :body => response_file('repos_watched_jcoutu.json'))
    FakeWeb.register_uri(:get, "https://#{auth}github.com/api/v2/json/repos/show/jcoutu", :body => response_file('repos_show_jcoutu.json'))

    #Loupe Responses
    FakeWeb.register_uri(:get, "https://#{auth}github.com/api/v2/json/repos/show/turingstudio/loupe", :body => response_file('loupe/repos_show_turingstudio_loupe.json'))
    FakeWeb.register_uri(:get, "https://#{auth}github.com/turingstudio/loupe/network_meta", :body => response_file('loupe/turingstudio_loupe_network_meta.json'))
    FakeWeb.register_uri(:get, "https://#{auth}github.com/turingstudio/loupe/network_data_chunk?nethash=068161e2c05a6b8029a7eb410dd27b1dfa531338&start=0&end=133", :body => response_file('loupe/turingstudio_loupe_network_data.json'))
    FakeWeb.register_uri(:get, "https://#{auth}github.com/api/v2/json/repos/show/turingstudio/loupe/branches", :body => response_file('loupe/repos_show_turingstudio_loupe_branches.json'))
    FakeWeb.register_uri(:get, "https://#{auth}github.com/turingstudio/loupe/network_data_chunk?nethash=068161e2c05a6b8029a7eb410dd27b1dfa531338&start=130&end=133", :body => response_file('loupe/turingstudio_loupe_068161e2c05a6b8029a7eb410dd27b1dfa531338?start=130.json'))
    FakeWeb.register_uri(:get, "https://#{auth}github.com/turingstudio/loupe/network_data_chunk?nethash=068161e2c05a6b8029a7eb410dd27b1dfa531338&start=1&end=5", :body => response_file('loupe/turingstudio_loupe_068161e2c05a6b8029a7eb410dd27b1dfa531338?start=1&end=5.json'))

    #Girl-Ambition Responses
    FakeWeb.register_uri(:get, "https://#{auth}github.com/turingstudio/website-girlambition/network_meta", :body => response_file('girlambition/turingstudio_website-girlambition_network_meta.json'))
    FakeWeb.register_uri(:get, "https://#{auth}github.com/api/v2/json/repos/show/turingstudio/website-girlambition/branches", :body => response_file('girlambition/repos_show_turingstudio_website-girlambition_branches.json'))
    FakeWeb.register_uri(:get, "https://#{auth}github.com/turingstudio/website-girlambition/network_data_chunk?nethash=0ead14b395f02f065083a6865dd06ede8b3153bc&start=0&end=500", :body => response_file('girlambition/0-500.json'), :content_length => 1)
    FakeWeb.register_uri(:get, "https://#{auth}github.com/turingstudio/website-girlambition/network_data_chunk?nethash=0ead14b395f02f065083a6865dd06ede8b3153bc&start=501&end=1001", :body => response_file('girlambition/501-1001.json'), :content_length => 1)
    FakeWeb.register_uri(:get, "https://#{auth}github.com/turingstudio/website-girlambition/network_data_chunk?nethash=0ead14b395f02f065083a6865dd06ede8b3153bc&start=1002&end=1502", :body => response_file('girlambition/1002-1502.json'), :content_length => 1)
    FakeWeb.register_uri(:get, "https://#{auth}github.com/turingstudio/website-girlambition/network_data_chunk?nethash=0ead14b395f02f065083a6865dd06ede8b3153bc&start=1503&end=2003", :body => response_file('girlambition/1503-2003.json'), :content_length => 1)
    FakeWeb.register_uri(:get, "https://#{auth}github.com/turingstudio/website-girlambition/network_data_chunk?nethash=0ead14b395f02f065083a6865dd06ede8b3153bc&start=2004&end=2504", :body => response_file('girlambition/2004-2504.json'), :content_length => 1)
    FakeWeb.register_uri(:get, "https://#{auth}github.com/turingstudio/website-girlambition/network_data_chunk?nethash=0ead14b395f02f065083a6865dd06ede8b3153bc&start=2505&end=3005", :body => response_file('girlambition/2505-3005.json'), :content_length => 1)
    FakeWeb.register_uri(:get, "https://#{auth}github.com/turingstudio/website-girlambition/network_data_chunk?nethash=0ead14b395f02f065083a6865dd06ede8b3153bc&start=3006&end=3506", :body => response_file('girlambition/3006-3506.json'), :content_length => 1)
    FakeWeb.register_uri(:get, "https://#{auth}github.com/turingstudio/website-girlambition/network_data_chunk?nethash=0ead14b395f02f065083a6865dd06ede8b3153bc&start=3507&end=4007", :body => response_file('girlambition/3507-4007.json'), :content_length => 1)
    FakeWeb.register_uri(:get, "https://#{auth}github.com/turingstudio/website-girlambition/network_data_chunk?nethash=0ead14b395f02f065083a6865dd06ede8b3153bc&start=4008&end=4508", :body => response_file('girlambition/4008-4508.json'), :content_length => 1)
    FakeWeb.register_uri(:get, "https://#{auth}github.com/turingstudio/website-girlambition/network_data_chunk?nethash=0ead14b395f02f065083a6865dd06ede8b3153bc&start=4509&end=4999", :body => response_file('girlambition/4509-4999.json'), :content_length => 1)

    #This needs to be refactored. It's dumb to do this!
    FakeWeb.register_uri(:get, "https://#{auth}github.com/api/v2/json/commits/list/turingstudio/loupe/51ac36280d2dfe16c37b66ef344859c9c714c8e1?page=0", :body => response_file('branch_pages/turingstudio_loupe_51ac36280d2dfe16c37b66ef344859c9c714c8e1?page=0.json'))
    FakeWeb.register_uri(:get, "https://#{auth}github.com/api/v2/json/commits/list/turingstudio/loupe/51ac36280d2dfe16c37b66ef344859c9c714c8e1?page=1", :body => response_file('branch_pages/turingstudio_loupe_51ac36280d2dfe16c37b66ef344859c9c714c8e1?page=1.json'))
    FakeWeb.register_uri(:get, "https://#{auth}github.com/api/v2/json/commits/list/turingstudio/loupe/51ac36280d2dfe16c37b66ef344859c9c714c8e1?page=2", :body => response_file('branch_pages/turingstudio_loupe_51ac36280d2dfe16c37b66ef344859c9c714c8e1?page=2.json'))
    FakeWeb.register_uri(:get, "https://#{auth}github.com/api/v2/json/commits/list/turingstudio/loupe/51ac36280d2dfe16c37b66ef344859c9c714c8e1?page=3", :body => response_file('branch_pages/turingstudio_loupe_51ac36280d2dfe16c37b66ef344859c9c714c8e1?page=3.json'))
    FakeWeb.register_uri(:get, "https://#{auth}github.com/api/v2/json/commits/list/turingstudio/loupe/51ac36280d2dfe16c37b66ef344859c9c714c8e1?page=4", :body => response_file('branch_pages/turingstudio_loupe_51ac36280d2dfe16c37b66ef344859c9c714c8e1?page=4.json'))
    FakeWeb.register_uri(:get, "https://#{auth}github.com/api/v2/json/commits/list/turingstudio/loupe/51ac36280d2dfe16c37b66ef344859c9c714c8e1?page=5", :body => response_file('branch_pages/turingstudio_loupe_51ac36280d2dfe16c37b66ef344859c9c714c8e1?page=5.json'))
    FakeWeb.register_uri(:get, "https://#{auth}github.com/api/v2/json/commits/list/turingstudio/loupe/bec7b23dc57b14d89fa2829e8c32a108a18e7248?page=0", :body => response_file('branch_pages/turingstudio_loupe_bec7b23dc57b14d89fa2829e8c32a108a18e7248?page=0.json'))
    FakeWeb.register_uri(:get, "https://#{auth}github.com/api/v2/json/commits/list/turingstudio/loupe/bec7b23dc57b14d89fa2829e8c32a108a18e7248?page=1", :body => response_file('branch_pages/turingstudio_loupe_bec7b23dc57b14d89fa2829e8c32a108a18e7248?page=1.json'))
    FakeWeb.register_uri(:get, "https://#{auth}github.com/api/v2/json/commits/list/turingstudio/loupe/bec7b23dc57b14d89fa2829e8c32a108a18e7248?page=2", :body => response_file('branch_pages/turingstudio_loupe_bec7b23dc57b14d89fa2829e8c32a108a18e7248?page=2.json'))
    FakeWeb.register_uri(:get, "https://#{auth}github.com/api/v2/json/commits/list/turingstudio/loupe/bec7b23dc57b14d89fa2829e8c32a108a18e7248?page=3", :body => response_file('branch_pages/turingstudio_loupe_bec7b23dc57b14d89fa2829e8c32a108a18e7248?page=3.json'))
    FakeWeb.register_uri(:get, "https://#{auth}github.com/api/v2/json/commits/list/turingstudio/loupe/bec7b23dc57b14d89fa2829e8c32a108a18e7248?page=4", :body => response_file('branch_pages/turingstudio_loupe_bec7b23dc57b14d89fa2829e8c32a108a18e7248?page=4.json'))
    FakeWeb.register_uri(:get, "https://#{auth}github.com/api/v2/json/commits/list/turingstudio/loupe/c3aeb61e37f94bbb67c4f14b52c23b8e54d30d0e?page=0", :body => response_file('branch_pages/turingstudio_loupe_c3aeb61e37f94bbb67c4f14b52c23b8e54d30d0e?page=0.json'))
    FakeWeb.register_uri(:get, "https://#{auth}github.com/api/v2/json/commits/list/turingstudio/loupe/c3aeb61e37f94bbb67c4f14b52c23b8e54d30d0e?page=1", :body => response_file('branch_pages/turingstudio_loupe_c3aeb61e37f94bbb67c4f14b52c23b8e54d30d0e?page=1.json'))
    FakeWeb.register_uri(:get, "https://#{auth}github.com/api/v2/json/commits/list/turingstudio/loupe/c3aeb61e37f94bbb67c4f14b52c23b8e54d30d0e?page=2", :body => response_file('branch_pages/turingstudio_loupe_c3aeb61e37f94bbb67c4f14b52c23b8e54d30d0e?page=2.json'))
    FakeWeb.register_uri(:get, "https://#{auth}github.com/api/v2/json/commits/list/turingstudio/loupe/c3aeb61e37f94bbb67c4f14b52c23b8e54d30d0e?page=3", :body => response_file('branch_pages/turingstudio_loupe_c3aeb61e37f94bbb67c4f14b52c23b8e54d30d0e?page=3.json'))
    FakeWeb.register_uri(:get, "https://#{auth}github.com/api/v2/json/commits/list/turingstudio/loupe/c3aeb61e37f94bbb67c4f14b52c23b8e54d30d0e?page=4", :body => response_file('branch_pages/turingstudio_loupe_c3aeb61e37f94bbb67c4f14b52c23b8e54d30d0e?page=4.json'))
  end
end
