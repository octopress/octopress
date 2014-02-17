module Octopress
  class Draft < Post
    def path
      source = @config['source']
      name = "#{title_slug}.#{extension}"
      File.join(source, '_drafts', name)
    end
  end
end
