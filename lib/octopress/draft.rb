module Octopress
  class Draft < Post

    def publish
      @options['title'] = read_title
      post_options = {
        'title'   => read_title,
        'content' => read_content,
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
      source = @config['source']
      name = "#{title_slug}.#{extension}"
      File.join(source, '_drafts', name)
    end

    def read
      if @content
        @content
      else
        file = @options['path']
        abort "File #{file} not found." if !File.exist? file
        @content = Pathname.new(file).read
      end
    end

    def read_title
      read.match(/title:\s+(.+)?$/)[1]
    end
    
    def read_content
      read.sub(/date:\s+.+?$/, "date: #{@options['date']}")
    end

  end
end
