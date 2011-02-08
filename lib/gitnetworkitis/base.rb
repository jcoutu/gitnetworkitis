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

    def get url
      ret = self.class.get(url)
      if ret.response.code == "200"
        return ret
      else
        raise "Unable to find Github Repository"
      end
    end

    def parse_json json
      begin
        return JSON.parse(escape_json(json))
      rescue => e
        raise "Unable to parse JSON result" #{e.message}
      end
    end


    private
    def parse_attributes(json, object)
      json.each do |key, value|
        method = "#{key}="
        if object.respond_to? method
          object.send(method, value) 
        end
      end
      object
    end

    #This is for parsing bad json returned from github
    def escape_json(json)
      json.gsub(/(....\[31m)./, '')
      end

    end
  end