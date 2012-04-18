module GitNetworkitis
  class Branch < Base
    attr_accessor :commit, :name, :owner, :repo

    #Retrieves all branches based on a specific repo.
    def find_all(options={})
      if options.has_key?(:owner) & options.has_key?(:repo)
        resp = get("/repos/#{options[:owner]}/#{options[:repo]}/branches")
        parse_json(escape_json(resp.body.to_s)).inject([]) do |branches, branch|
          branches << parse_attributes(branch, Branch.new(token, :owner => options[:owner], :repo => options[:repo]))
        end
      end
    end

    def commits(options={})
      opts = {access_token: token, per_page: 100, batch: true}.merge options
      CommitGetter.new("/repos/#{owner}/#{repo}/commits?sha=#{commit['sha']}", opts).get
    end

  end
end
