module GitNetworkitis
  class NetworkData < Base
    base_uri 'https://github.com/'

    attr_accessor :commits


    def find(options={})
      if options.has_key?(:owner) & options.has_key?(:repo) & options.has_key?(:nethash) 
        resp = self.class.get("/#{options[:owner]}/#{options[:repo]}/network_data_chunk?nethash=#{options[:nethash]}")
        json_result = JSON.parse(resp.body.to_s)
        result = Array.new
        json_result["commits"].each do |commit|
          result.push parse_attributes(commit, Commit.new(self.username, self.token))
        end 
        self.commits = result
        #This seems weird but what if later the api adds more data at this level? We could just return commits and change the name.
        return self
      end
    end
  end
end