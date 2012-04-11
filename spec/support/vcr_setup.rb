require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = "spec/vcr_cassettes"
  config.hook_into :fakeweb
  config.default_cassette_options = { serialize_with: :json }
end
