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
      return find_range(options.merge!({:start => 0, :end => self.network_meta.focus}))
    end

    def find_since(options={})
      self.network_meta = options[:network_meta]
      return find_range(options.merge!({:end => self.network_meta.focus}))
    end

    def find_range(options={})
      #Make this loop through pages so we dont' return huge results in one json calls
      self.network_meta = options[:network_meta]
      self.commits = Array.new

      current_start = options[:start]
      current_end = options[:end]
      while (options[:end] - current_start) > 500 do
        current_end = current_start + 500
        resp = get("/#{options[:owner]}/#{options[:repo]}/network_data_chunk?nethash=#{self.network_meta.nethash}&start=#{current_start}&end=#{current_end}")
        if resp.content_length > 0
          parse_results(resp)
        end
        current_start = current_start + 501
      end
      resp = self.get("/#{options[:owner]}/#{options[:repo]}/network_data_chunk?nethash=#{self.network_meta.nethash}&start=#{current_start}&end=#{options[:end]}")
      parse_results(resp)      
      
      return self
    end

    private
    def parse_results(response)
      begin
        json_result = parse_json(escape_json(response.body.to_s))
        result = Array.new
        json_result["commits"].each do |commit|
          self.commits.push(parse_attributes(commit, Commit.new(self.username, self.token)))
        end 
      rescue
        self.commits = []
      end
    end
        
  end
end