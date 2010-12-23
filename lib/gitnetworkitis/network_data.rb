module GitNetworkitis
  class NetworkData < Base
    base_uri 'https://github.com/'

    attr_accessor :commits, :network_meta

    def find(options={})
      if options.has_key?(:owner) & options.has_key?(:repo) & options.has_key?(:network_meta) 
        self.network_meta = options[:network_meta]
        resp = self.class.get("/#{options[:owner]}/#{options[:repo]}/network_data_chunk?nethash=#{self.network_meta.nethash}")
        json_result = JSON.parse(resp.body.to_s)
        result = Array.new
        json_result["commits"].each do |commit|
          #result.push parse_attributes(commit, Commit.new(self.username, self.token))
          temp_commit = parse_attributes(commit, Commit.new(self.username, self.token))
          result.push temp_commit
        end 
        self.commits = result
        set_branch_names
        #This seems weird but what if later the api adds more data at this level? We could just return commits and change the name.
        return self
      end
    end
    
    def set_branch_names()
      branch_number = 0
      network_meta.branches.each do |branch|
        current = commits.select{|v| v.id == branch.id}   #=> ["a", "e"]}
        if !current.empty?
          current.each
          puts current.first.parents[0][0].inspect
        end
        branch_number.next
      end
    end
  end
end