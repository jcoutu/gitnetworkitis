module GitNetworkitis
  class Repository < Base
    base_uri 'https://github.com/api/v2/json/'

    attr_accessor :description, :has_wiki, :url, :forks, :open_issues, :forks, :name, :homepage, :watchers, :owner, :private, :pledgie, :size, :has_downloads

    def find_all_watched(options={})
      resp = self.class.get("/repos/watched/#{self.username}")
      json_result = JSON.parse(resp.body.to_s)
      result = Array.new
      json_result["repositories"].each do |repo|
        result.push parse_attributes(repo)
      end
      
      return result
    end

    def find_all_owned(options={})
      resp = self.class.get("/repos/show/#{self.username}")
      json_result = JSON.parse(resp.body.to_s)

      result = Array.new
      json_result["repositories"].each do |repo|
        result.push parse_attributes(repo)
      end
      
      return result
    end

    def find(options={})
      resp = self.class.get("/repos/show/turingstudio/loupe")
      json_result = JSON.parse(resp.body.to_s)
      parse_attributes(json_result["repository"])
    end
    
    private
    
    def parse_attributes(repo)
      temp = Repository.new self.username, self.token
      repo.each do |key, value|
        method = "#{key}="
        temp.send(method, value) if respond_to? method
      end
      temp
    end
  end
end
