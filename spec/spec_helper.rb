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
  }
end
