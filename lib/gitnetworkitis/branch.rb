module GitNetworkitis
  class Branch < Base
    base_uri 'https://github.com/api/v2/json/'

    attr_accessor :name, :id, :owner, :repo

    def find_all(options={})
      if options.has_key?(:owner) & options.has_key?(:repo) 
        resp = self.class.get("/repos/show/#{options[:owner]}/#{options[:repo]}/branches")
        json_result = JSON.parse(resp.body.to_s)
        result = Array.new
        json_result["branches"].each do |branch|
          result.push Branch.new(self.username, self.token, {:name =>branch[0], :id => branch[1], :owner => options[:owner], :repo => options[:repo]})
        end
        return result
      end
    end
    
    def commits
      puts self.id
      resp = self.class.get("/commits/list/#{self.owner}/#{self.repo}/#{self.id}?page=4")
      json_result = JSON.parse(resp.body.to_s)
      result = Array.new
      json_result["commits"].each do |commit|
        temp_commit = parse_attributes(commit, Commit.new(self.username, self.token))
        result.push temp_commit
      end
      puts result.length
      result
    end
    
  end
end