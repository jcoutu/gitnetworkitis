module GitNetworkitis
  class Commit < Base
    base_uri 'https://github.com/'

    attr_accessor :parents, :author, :time, :id, :date, :gravatar, :space, :message, :login

  end
end