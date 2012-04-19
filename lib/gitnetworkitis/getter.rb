module GitNetworkitis
  class Getter
    include HTTParty
    include JSONHelper
    base_uri 'https://api.github.com'

    attr_accessor :url, :local_options, :query_options

    LOCAL_KEYS = [:batch, :since, :branch]

    def initialize(url, options={})
      @url = url
      scrub_local_options options
      @query_options = options
    end

    def get
      local_options[:batch] ? batched_get : single_get
    end

    private
    def scrub_local_options(options={})
      @local_options = LOCAL_KEYS.inject({}) {|opts, key| opts[key] = options.delete(key); opts }
      @local_options[:batch] = true unless @local_options[:since].nil?
    end

    def single_get(use_query_options=true)
      ret = use_query_options ? Getter.get(url, query: query_options) : Getter.get(url)
      if ret.response.code == "200"
        return ret
      else
        raise "Unable to find Github Repository"
      end
    end

    def batched_get
      resps = []
      links = {next: url}
      first_batch = true
      while links[:next] do
        self.url = links[:next]
        resp = single_get first_batch
        resps << resp
        first_batch = false
        links = build_links_from_headers resp.headers['link']
      end
      BatchResponse.new resps
    end

    # see the json files in spec/vcr_cassettes for examples of what the link headers look like
    def build_links_from_headers(headers)
      return {} if headers.nil?

      links = headers.split(',')
      links.inject({}) do |rel, link|
        l = link.strip.split(';')
        next_link = l.first[1...-1]  # [1...-1] because the actual link is enclosed within '<' '>' tags
        rel_command = l.last.strip.match(/rel=\"(.*)\"/).captures.first.to_sym  # e.g. "rel=\"next\"" #=> :next
        rel.tap {|r| r[rel_command] = next_link }
      end
    end

  end
end
