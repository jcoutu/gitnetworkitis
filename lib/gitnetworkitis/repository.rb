module GitNetworkitis
  class Repository < Base
    base_uri 'https://github.com/api/v2/json/'

    attr_accessor :description, :has_wiki, :url, :forks, :open_issues, :forks, :name, :homepage, :watchers, :owner, :private, :pledgie, :size, :has_downloads

    def find_all_watched
      result = Array.new
      unless !self.username && !self.token
        resp = self.class.get("/repos/watched/#{self.username}")
        json_result = JSON.parse(resp.body.to_s)
        json_result["repositories"].each do |repo|
          result.push parse_attributes(repo, Repository.new(self.username, self.token))
        end
      end
      return result
    end

    def find_all_owned
      result = Array.new
      unless !self.username && !self.token
        resp = self.class.get("/repos/show/#{self.username}")
        json_result = JSON.parse(resp.body.to_s)
        json_result["repositories"].each do |repo|
          result.push parse_attributes(repo, Repository.new(self.username, self.token))
        end
      end
      return result
    end

    def find(options={})
      result = Array.new
      if options.has_key?(:owner) & options.has_key?(:repo) 
        resp = self.class.get("/repos/show/#{options[:owner]}/#{options[:repo]}")
        json_result = JSON.parse(resp.body.to_s)
        parse_attributes(json_result["repository"], Repository.new(self.username, self.token))
      end
    end

    def remote_id
        return "#{self.owner}/#{self.name}"
    end

  end
end
