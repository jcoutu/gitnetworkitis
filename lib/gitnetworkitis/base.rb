module GitNetworkitis
  class Base
    include JSONHelper
    attr_accessor :token

    # token is an oauth2 token
    def initialize(token, options={})
      @token = token
      options.each do |key, value|
        method = "#{key}="
        self.send(method, value) if respond_to? method
      end
    end

    # see Getter for options
    def get(url, options={})
      opts = {access_token: token}.merge options
      Getter.new(url, opts).get
    end
  end
end
