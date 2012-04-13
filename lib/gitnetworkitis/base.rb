module GitNetworkitis
  class Base
    include HTTParty
    attr_accessor :token

    # token is an oauth2 token
    def initialize(token, options={})
      @token = token
      options.each do |key, value|
        method = "#{key}="
        self.send(method, value) if respond_to? method
      end
    end

    def parse_json json
      return JSON.parse(escape_json(json))
    rescue => e
      raise "Unable to parse JSON result" #{e.message}
    end

    # current useful options are :per_page (integer), :batch (boolean), and :since (a git SHA)
    def get url, options={}
      batch = options.key?(:since) ? true : options.delete(:batch)
      query_options = {access_token: token}.merge options
      batch ? batched_get(url, query_options) : single_get(url, query_options)
    end

    private

    #This is for parsing bad json returned from github
    def escape_json(json)
      json.gsub(/(....\[31m)./, '')
    end

    def single_get url, query_options
      ret = self.class.get(url, query: query_options)
      if ret.response.code == "200"
        return ret
      else
        raise "Unable to find Github Repository"
      end
    end

    def batched_get url, query_options
      resps = []
      links = {next: url}
      while links[:next] do
        resp = single_get(links[:next], query_options)
        resps << resp
        links = build_links_from_headers resp.headers['link']
      end
      BatchResponse.new resps
    end

    # link headers come in a format like:
    #   "<https://api.github.com/repos/jcoutu/gitnetworkitis/commits?access_token=<ACCESS_TOKEN>&last_sha=<LAST_SHA>&per_page=15&sha=<SHA>&top=<SHA>>; rel=\"next\",
    #   <https://api.github.com/repos/jcoutu/gitnetworkitis/commits?access_token=<ACCESS_TOKEN>&per_page=15&sha=<SHA>>; rel=\"first\""
    # (line break added for readability)
    def build_links_from_headers headers
      return {} if headers.nil?

      links = headers.split(',')
      links.inject({}) do |rel, link|
        l = link.strip.split(';')
        next_link = l.first[1...-1]  # [1...-1] because the actual link is enclosed within '<' '>' tags
        rel_command = l.last.strip.match(/rel=\"(.*)\"/).captures.first.to_sym  # e.g. "rel=\"next\"" #=> :next
        rel.tap {|r| r[rel_command] = next_link }
      end
    end

    def parse_attributes(json, object)
      json.each do |key, value|
        method = "#{key}="
        if object.respond_to? method
          object.send(method, value)
        end
      end
      object
    end

  end
end
