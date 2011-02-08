module GitNetworkitis
  class NetworkMeta < Base
    base_uri 'https://github.com/'

    attr_accessor :spacemap, :blocks, :url, :nethash, :focus, :dates, :users, :branches

    def find(options={})
      if options.has_key?(:owner) & options.has_key?(:repo) 
        resp = get("/#{ options[:owner]}/#{ options[:repo]}/network_meta")
        json_result = parse_json(resp.body.to_s)
        branch = GitNetworkitis::Branch.new(@username, @token)
        self.branches = branch.find_all({:owner=>options[:owner], :repo => options[:repo]})
        parse_attributes(json_result, self)
      end
    end
  end
end