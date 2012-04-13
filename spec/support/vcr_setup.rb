require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = "spec/vcr_cassettes"
  config.hook_into :fakeweb
  config.default_cassette_options = { serialize_with: :json }
  config.filter_sensitive_data('<ACCESS TOKEN>') { YAML.load_file(File.join(File.dirname(__FILE__), '../', 'github_config.yml'))['access_token'] }
end
