module GitNetworkitis
  class Repository < Base
    base_uri 'https://api.github.com/'

    attr_accessor :watchers, :homepage, :has_downloads, :forks, :url, :has_wiki, :size, :private
    attr_accessor :owner, :name, :description, :open_issues

    #TODO use options to handle the optional filter params that github v3 supports
    def find_all(options={})
      resp = get("/user/repos")
      parse_json(resp.body.to_s).inject([]) do |repos, repo|
        repos << parse_attributes(repo, Repository.new(token))
      end
    end

    def find(options={})
      if options.has_key?(:owner) & options.has_key?(:repo)
        resp = get("/repos/#{options[:owner]}/#{options[:repo]}")
        parse_attributes(parse_json(resp.body.to_s), Repository.new(token))
      end
    end

    def remote_id
      return "#{self.owner['login']}/#{self.name}"
    end

  end
end
