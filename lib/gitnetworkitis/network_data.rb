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
          temp_commit = parse_attributes(commit, Commit.new(self.username, self.token))
          result.push temp_commit
        end 
        self.commits = set_branch_names(result)
        #puts self.commits.inspect
        #This seems weird but what if later the api adds more data at this level? We could just return commits and change the name.
        return self
      end
    end

    def set_branch_names(commits)
      branch_number = 0
      result = Array.new
      network_meta.branches.each do |branch|
        if !commits.empty?
          commits.each do |current|
            if current.space == branch_number
              if branch_number == 0
                current.branch = branch
                result.push current
              else
                if verify_commits_branch(current, branch)
                  current.branch = branch
                  result.push current
                end
              end
            end
          end
        end
        branch_number=branch_number+1
      end
      return result
    end

    def verify_commits_branch(commit, branch)
      resp = self.class.get("/api/v2/json/commits/show/#{self.network_meta.users[0]["name"]}/#{self.network_meta.users[0]["repo"]}/#{branch.id}/#{commit.id}")
      json_result = JSON.parse(resp.body.to_s)
      temp_commit = parse_attributes(json_result["commit"], Commit.new(self.username, self.token))
      if temp_commit.id == commit.id
        return true
      else
        return false
      end
    end

  end
end