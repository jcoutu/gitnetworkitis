module GitNetworkitis
  class Base
    include HTTParty
    attr_accessor :username, :token

    def initialize(username, token, options={})
      @username = username
      @token = token
      self.class.basic_auth "#{username}/token", token
      options.each do |key, value|
        method = "#{key}="
        self.send(method, value) if respond_to? method
      end
    end
  end
end