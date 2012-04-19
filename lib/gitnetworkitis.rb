require 'httparty'
require 'json'

['gitnetworkitis/json_helper',
 'gitnetworkitis/base',
 'gitnetworkitis/commit',
 'gitnetworkitis/repository',
 'gitnetworkitis/branch',
 'gitnetworkitis/getter',
 'gitnetworkitis/commit_getter',
 'gitnetworkitis/batch_response'].each {|f| require File.join(File.dirname(__FILE__), f) }

module GitNetworkitis


end
