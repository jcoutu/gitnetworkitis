module GitNetworkitis
  class Repository < Base
    attr_accessor :watchers, :homepage, :has_downloads, :forks, :url, :has_wiki, :size, :private
    attr_accessor :owner, :name, :description, :open_issues

    #TODO use options to handle the optional filter params that github v3 supports
    def find_all(options={})
      include_orgs = options.delete(:include_orgs)
      resp = get("/user/repos", type: (options[:type] || 'all'))
      user_repos = parse_json(resp.body.to_s).inject([]) do |repos, repo|
        repos << parse_attributes(repo, Repository.new(token))
      end

      include_orgs ? user_repos + org_member_repos : user_repos
    end

    def org_member_repos
      resp = get("/user/orgs")
      org_names = parse_json(resp.body.to_s).map {|o| o['login'] }
      org_names.inject([]) do |org_repos, org_name|
        resp = get("/orgs/#{org_name}/repos", type: 'member')
        org_repos += parse_json(resp.body.to_s).inject([]) do |this_org_repos, repo|
          this_org_repos << parse_attributes(repo, Repository.new(token))
        end
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
