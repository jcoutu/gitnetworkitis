module GitNetworkitis
  class Branch < Base
    base_uri 'https://api.github.com/'

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
      opts = {:per_page => 100, :batch => true}.merge options
      opts[:since] ? since_commits(opts) : all_commits(opts)
    end


    private

    def all_commits(options={})
      build_commits get("/repos/#{owner}/#{repo}/commits?sha=#{commit['sha']}", options)
    end

    def since_commits(options={})
      local_options = scrub_local_options options
      links = {next: "/repos/#{owner}/#{repo}/commits?sha=#{commit['sha']}"}
      results = []
      while links[:next] do
        resp = single_get(links[:next], options)
        staged_commits = build_commits resp
        since_index = staged_commits.find_index {|c| c.sha == local_options[:since] }
        if since_index
          results += staged_commits.first(since_index)
          links = {}
        else
          results << staged_commits
          links = build_links_from_headers resp.headers['link']
        end
      end
      results
    end

    def build_commits(response)
      parse_json(escape_json(response.body.to_s)).inject([]) do |commits, commit|
        commit_attrs = commit['commit'].merge('sha' => commit['sha'], 'parents' => commit['parents'])
        parsed_commit = parse_attributes(commit_attrs, Commit.new(token))
        commits << parsed_commit
      end
    end

  end
end
