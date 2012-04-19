module GitNetworkitis
  # This class serves as a sort of proxy for HTTParty::Response. When a
  # Base#batched_get is performed, a BatchResponse object is returned,
  # with a #body made up of the concatenation of its responses'. This
  # way, paged responses (like for commits) can appear as a single
  # response body to the code that handles it. This is necessary
  # because HTTParty::Response has no setter on its #body attribute,
  # and sets it directly from its #response on #initialize.
  class BatchResponse

    attr_reader :responses, :body

    def initialize responses
      @responses = responses

      # Since we're combining response bodies, we have a series of JSON
      # arrays that need to be joined (hence the gsub).
      @body = responses.map {|r| r.body.to_s }.
                        join('').
                        gsub(/\]\[/, ', ')
    end

  end
end
