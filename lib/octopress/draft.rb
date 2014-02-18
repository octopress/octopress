module Octopress
  class Draft < Post

    def publish
      post_options = {
        'title'   => read_draft_title,
        'content' => read_draft_content,
        'type'    => 'post from draft'
      }
      Post.new(post_options).write
      FileUtils.rm @options['path']
    end

    def set_default_options
      super
      @options['type'] = 'draft' 
    end

    def path
      name = "#{title_slug}.#{extension}"
      File.join(@config['jekyll']['source'], '_drafts', name)
    end

    def read
      if @draft_content
        @draft_content
      else
        file = @options['path']
        abort "File #{file} not found." if !File.exist? file
        @draft_content = Pathname.new(file).read
      end
    end

    def read_draft_title
      read.match(/title:\s+(.+)?$/)[1]
    end
    
    def read_draft_content
      read.sub(/date:\s+.+?$/, "date: #{@options['date']}")
    end

  end
end
