require 'httparty'

# GitNetworkitis stuff
# By sorting them we ensure that api and base are loaded first on all sane operating systems
Dir[File.join(File.dirname(__FILE__), "gitnetworkitis/*.rb")].sort.each { |f| require f }

class GitNetworkitis
  attr_accessor :username, :token
  
  def initialize(username,token)
    @username = username
    @token = token
  end
end