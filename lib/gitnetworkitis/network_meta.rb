module GitNetworkitis
  class NetworkMeta < Base
    base_uri 'https://github.com/'

    attr_accessor :spacemap, :blocks, :url, :nethash, :focus, :dates, :users, :heads


    def find(options={})
      if options.has_key?(:owner) & options.has_key?(:repo) 
        resp = self.class.get("/turingstudio/loupe/network_meta")
        json_result = JSON.parse(resp.body.to_s)
        parse_attributes(json_result, NetworkMeta.new(self.username, self.token))
      end
    end
  end
end