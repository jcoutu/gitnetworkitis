$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'gitnetworkitis'
require 'fakeweb'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|

end

def response_file(*path)
  File.join(File.dirname(__FILE__), "responses", path)
end

def fake_responses
  #FakeWeb.allow_net_connect = false
  FakeWeb.clean_registry
  auth = "jcoutu%2Ftoken:0ea98987469a2ef1daee5d1e30b42fd8@"
  FakeWeb.register_uri(:get, "https://#{auth}github.com/api/v2/json/repos/watched/jcoutu", :body => response_file('repos_watched_jcoutu.json'))
  FakeWeb.register_uri(:get, "https://#{auth}github.com/api/v2/json/repos/show/jcoutu", :body => response_file('repos_show_jcoutu.json'))
  FakeWeb.register_uri(:get, "https://#{auth}github.com/api/v2/json/repos/show/turingstudio/loupe", :body => response_file('reps_show_turingstudio_loupe.json'))
end
