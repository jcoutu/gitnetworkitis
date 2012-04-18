module GitNetworkitis
  class Commit < Base
    attr_accessor :sha, :url, :author, :committer, :message, :tree, :parents
  end
end
