module GitNetworkitis
  class CommitGetter < Getter
    def get
      if local_options[:since]
        since_commits
      else
        response = super
        build_commits response
      end
    end

    private

    def since_commits
      since_date = DateTime.parse local_options[:since]
      since_date_commits
    rescue ArgumentError => e
      since_sha_commits
    end

    def since_date_commits

    end

    def since_sha_commits
      links = {next: url}
      results = []
      while links[:next] do
        self.url = links[:next]
        resp = single_get
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
        parsed_commit = parse_attributes(commit_attrs, Commit.new(query_options[:access_token]))
        commits << parsed_commit
      end
    end

  end
end
