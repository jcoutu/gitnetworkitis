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
    #Github username
    @username = "jcoutu"

    #Github Toekn
    @token = "0ea98987469a2ef1daee5d1e30b42fd8"

    #This will tell the tests to use fakeweb responses or not. Removing this will mostly likely cause test failures
    @fake_web_requests = true
    
  }
end


def response_file(*path)
  File.join(File.dirname(__FILE__), "responses", path)
end

def fake_responses
  if @fake_web_requests
    FakeWeb.allow_net_connect = false
    FakeWeb.clean_registry
    auth = "#{@username}%2Ftoken:#{@token}@"
    FakeWeb.register_uri(:get, "https://#{auth}github.com/api/v2/json/repos/watched/jcoutu", :body => response_file('repos_watched_jcoutu.json'))
    FakeWeb.register_uri(:get, "https://#{auth}github.com/api/v2/json/repos/show/jcoutu", :body => response_file('repos_show_jcoutu.json'))
    FakeWeb.register_uri(:get, "https://#{auth}github.com/api/v2/json/repos/show/turingstudio/loupe", :body => response_file('repos_show_turingstudio_loupe.json'))
    FakeWeb.register_uri(:get, "https://#{auth}github.com/turingstudio/loupe/network_meta", :body => response_file('turingstudio_loupe_network_meta.json'))
    FakeWeb.register_uri(:get, "https://#{auth}github.com/turingstudio/loupe/network_data_chunk?nethash=068161e2c05a6b8029a7eb410dd27b1dfa531338", :body => response_file('turingstudio_loupe_network_data.json'))
    FakeWeb.register_uri(:get, "https://#{auth}github.com/api/v2/json/repos/show/turingstudio/loupe/branches", :body => response_file('repos_show_turingstudio_loupe_branches.json'))
    
    #This needs to be refactored. It's dumb to do this!
    FakeWeb.register_uri(:get, "https://#{auth}github.com/api/v2/json/commits/list/turingstudio/loupe/51ac36280d2dfe16c37b66ef344859c9c714c8e1?page=0", :body => response_file('turingstudio_loupe_51ac36280d2dfe16c37b66ef344859c9c714c8e1?page=0.json'))
    FakeWeb.register_uri(:get, "https://#{auth}github.com/api/v2/json/commits/list/turingstudio/loupe/51ac36280d2dfe16c37b66ef344859c9c714c8e1?page=1", :body => response_file('turingstudio_loupe_51ac36280d2dfe16c37b66ef344859c9c714c8e1?page=1.json'))
    FakeWeb.register_uri(:get, "https://#{auth}github.com/api/v2/json/commits/list/turingstudio/loupe/51ac36280d2dfe16c37b66ef344859c9c714c8e1?page=2", :body => response_file('turingstudio_loupe_51ac36280d2dfe16c37b66ef344859c9c714c8e1?page=2.json'))
    FakeWeb.register_uri(:get, "https://#{auth}github.com/api/v2/json/commits/list/turingstudio/loupe/51ac36280d2dfe16c37b66ef344859c9c714c8e1?page=3", :body => response_file('turingstudio_loupe_51ac36280d2dfe16c37b66ef344859c9c714c8e1?page=3.json'))
    FakeWeb.register_uri(:get, "https://#{auth}github.com/api/v2/json/commits/list/turingstudio/loupe/51ac36280d2dfe16c37b66ef344859c9c714c8e1?page=4", :body => response_file('turingstudio_loupe_51ac36280d2dfe16c37b66ef344859c9c714c8e1?page=4.json'))
    FakeWeb.register_uri(:get, "https://#{auth}github.com/api/v2/json/commits/list/turingstudio/loupe/51ac36280d2dfe16c37b66ef344859c9c714c8e1?page=5", :body => response_file('turingstudio_loupe_51ac36280d2dfe16c37b66ef344859c9c714c8e1?page=5.json'))
    FakeWeb.register_uri(:get, "https://#{auth}github.com/api/v2/json/commits/list/turingstudio/loupe/bec7b23dc57b14d89fa2829e8c32a108a18e7248?page=0", :body => response_file('turingstudio_loupe_bec7b23dc57b14d89fa2829e8c32a108a18e7248?page=0.json'))
    FakeWeb.register_uri(:get, "https://#{auth}github.com/api/v2/json/commits/list/turingstudio/loupe/bec7b23dc57b14d89fa2829e8c32a108a18e7248?page=1", :body => response_file('turingstudio_loupe_bec7b23dc57b14d89fa2829e8c32a108a18e7248?page=1.json'))
    FakeWeb.register_uri(:get, "https://#{auth}github.com/api/v2/json/commits/list/turingstudio/loupe/bec7b23dc57b14d89fa2829e8c32a108a18e7248?page=2", :body => response_file('turingstudio_loupe_bec7b23dc57b14d89fa2829e8c32a108a18e7248?page=2.json'))
    FakeWeb.register_uri(:get, "https://#{auth}github.com/api/v2/json/commits/list/turingstudio/loupe/bec7b23dc57b14d89fa2829e8c32a108a18e7248?page=3", :body => response_file('turingstudio_loupe_bec7b23dc57b14d89fa2829e8c32a108a18e7248?page=3.json'))
    FakeWeb.register_uri(:get, "https://#{auth}github.com/api/v2/json/commits/list/turingstudio/loupe/bec7b23dc57b14d89fa2829e8c32a108a18e7248?page=4", :body => response_file('turingstudio_loupe_bec7b23dc57b14d89fa2829e8c32a108a18e7248?page=4.json'))
    FakeWeb.register_uri(:get, "https://#{auth}github.com/api/v2/json/commits/list/turingstudio/loupe/c3aeb61e37f94bbb67c4f14b52c23b8e54d30d0e?page=0", :body => response_file('turingstudio_loupe_c3aeb61e37f94bbb67c4f14b52c23b8e54d30d0e?page=0.json'))
    FakeWeb.register_uri(:get, "https://#{auth}github.com/api/v2/json/commits/list/turingstudio/loupe/c3aeb61e37f94bbb67c4f14b52c23b8e54d30d0e?page=1", :body => response_file('turingstudio_loupe_c3aeb61e37f94bbb67c4f14b52c23b8e54d30d0e?page=1.json'))
    FakeWeb.register_uri(:get, "https://#{auth}github.com/api/v2/json/commits/list/turingstudio/loupe/c3aeb61e37f94bbb67c4f14b52c23b8e54d30d0e?page=2", :body => response_file('turingstudio_loupe_c3aeb61e37f94bbb67c4f14b52c23b8e54d30d0e?page=2.json'))
    FakeWeb.register_uri(:get, "https://#{auth}github.com/api/v2/json/commits/list/turingstudio/loupe/c3aeb61e37f94bbb67c4f14b52c23b8e54d30d0e?page=3", :body => response_file('turingstudio_loupe_c3aeb61e37f94bbb67c4f14b52c23b8e54d30d0e?page=3.json'))
    FakeWeb.register_uri(:get, "https://#{auth}github.com/api/v2/json/commits/list/turingstudio/loupe/c3aeb61e37f94bbb67c4f14b52c23b8e54d30d0e?page=4", :body => response_file('turingstudio_loupe_c3aeb61e37f94bbb67c4f14b52c23b8e54d30d0e?page=4.json'))
    
  end
end
