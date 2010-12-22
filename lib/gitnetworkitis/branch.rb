module GitNetworkitis
  class Branch < Base
    base_uri 'https://github.com/api/v2/json/'

    attr_accessor :name, :id

    def find_all(options={})
      if options.has_key?(:owner) & options.has_key?(:repo) 
        resp = self.class.get("/repos/show/#{ options[:owner]}/#{ options[:repo]}/branches")
        json_result = JSON.parse(resp.body.to_s)
        result = Array.new
        json_result["branches"].each do |branch|
          result.push Branch.new(self.username, self.token, {:name=>branch[0], :id=> branch[1]})
        end
        return result
      end
    end
  end
end