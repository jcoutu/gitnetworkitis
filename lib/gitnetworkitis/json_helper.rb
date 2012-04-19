module GitNetworkitis
  module JSONHelper
    def parse_json(json)
      return JSON.parse(escape_json(json))
    rescue => e
      raise "Unable to parse JSON result" #{e.message}
    end

    #This is for parsing bad json returned from github
    def escape_json(json)
      json.gsub(/(....\[31m)./, '')
    end

    def parse_attributes(json, object)
      json.each do |key, value|
        method = "#{key}="
        if object.respond_to? method
          object.send(method, value)
        end
      end
      object
    end
  end
end
