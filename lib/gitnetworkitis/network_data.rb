module GitNetworkitis
  class NetworkData < Base
    base_uri 'https://github.com/'

    attr_accessor :commits, :network_meta

    def find(options={})
      if options.has_key?(:owner) & options.has_key?(:repo) & options.has_key?(:network_meta) 
        if options.has_key?(:start) & options.has_key?(:end)
          find_range(options)
        elsif options.has_key?(:start) & !options.has_key?(:end)
          find_since(options)
        else
          find_all(options)
        end
      else
        raise "You must provide an Owner, Repo and Gitnetworkitis:NetworkMeta" 
      end
    end

    def find_all(options={})
      self.network_meta = options[:network_meta]
      resp = self.class.get("/#{options[:owner]}/#{options[:repo]}/network_data_chunk?nethash=#{self.network_meta.nethash}&start=0&end=#{self.network_meta.focus}")
      return parse_results(resp)
    end

    def find_since(options={})
      self.network_meta = options[:network_meta]
      resp = self.class.get("/#{options[:owner]}/#{options[:repo]}/network_data_chunk?nethash=#{self.network_meta.nethash}&start=#{options[:start]}&end=#{self.network_meta.focus}")
      return parse_results(resp)
    end

    def find_range(options={})
      self.network_meta = options[:network_meta]
      resp = self.class.get("/#{options[:owner]}/#{options[:repo]}/network_data_chunk?nethash=#{self.network_meta.nethash}&start=#{options[:start]}&end=#{options[:end]}")
      return parse_results(resp)
    end

    def parse_results(response)
      json_result = JSON.parse(response.body.to_s)
      result = Array.new
      json_result["commits"].each do |commit|
        temp_commit = parse_attributes(commit, Commit.new(self.username, self.token))
        result.push temp_commit
      end 
      self.commits = result
      return self      
    end
  end
end