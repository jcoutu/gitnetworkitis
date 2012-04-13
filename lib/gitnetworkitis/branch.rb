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
      paging_options = {:per_page => 100, :batch => true}.merge options
      resp = get("/repos/#{owner}/#{repo}/commits?sha=#{commit['sha']}", paging_options)
      parse_json(escape_json(resp.body.to_s)).inject([]) do |commits, commit|
        commit_attrs = commit['commit'].merge('sha' => commit['sha'], 'parents' => commit['parents'])
        parsed_commit = parse_attributes(commit_attrs, Commit.new(token))
        commits << parsed_commit
      end
    end

    #Loops pages and returns all commits specific to a branch
    # def commits
    #   pages = true
    #   counter = 0
    #   result = Array.new
    #   while pages do
    #     resp = self.get("/repos/#{self.owner}/#{self.repo}/commits?sha=#{commit['sha']}&last_sha=#{commit['sha']}&page=#{counter}")
    #     parse_json(escape_json(resp.body.to_s)).each do |commit|
    #       parsed_commit = parse_attributes(commit, Commit.new(token))
    #       if result.detect {|existing_commit| existing_commit.sha == parsed_commit.sha }
    #         pages = true
    #         break
    #       else
    #         result << parsed_commit
    #       end
    #     end
    #     counter = counter + 1
    #   end
    #   result
    # end
  end
end
