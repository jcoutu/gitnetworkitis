module GitNetworkitis
  class Repository < Base
    base_uri 'https://github.com/api/v2/json/'

    attr_accessor :description, :has_wiki, :url, :forks, :open_issues, :forks, :name, :homepage, :watchers, :owner, :private, :pledgie, :size, :has_downloads

    def find_all_watched(options={})
      resp = self.class.get("/repos/watched/#{self.username}")
      json_result = JSON.parse(resp.body.to_s)
      result = Array.new
      json_result["repositories"].each do |repo|
        result.push parse_attributes(repo, Repository.new(self.username, self.token))
      end

      return result
    end

    def find_all_owned(options={})
      resp = self.class.get("/repos/show/#{self.username}")
      json_result = JSON.parse(resp.body.to_s)
      result = Array.new
      json_result["repositories"].each do |repo|
        result.push parse_attributes(repo, Repository.new(self.username, self.token))
      end

      return result
    end

    def find(options={})
      if options.has_key?(:owner) & options.has_key?(:repo) 
        resp = self.class.get("/repos/show/#{options[:owner]}/#{options[:repo]}")
        json_result = JSON.parse(resp.body.to_s)
        parse_attributes(json_result["repository"], Repository.new(self.username, self.token))
      end
    end
  end
end
