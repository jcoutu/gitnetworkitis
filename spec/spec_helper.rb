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
  end
end
