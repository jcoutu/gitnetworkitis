module GitNetworkitis
  class Commit < Base
    base_uri 'https://api.github.com/'

    attr_accessor :sha, :url, :author, :committer, :message, :tree, :parents

  end
end
