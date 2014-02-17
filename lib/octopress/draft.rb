module Octopress
  class Draft < Post

    def publish
      post_options = {
        'title'   => read_title
        'content' => read_content,
        'path'    => publish_path
      }

      Post.new(post_options).write

      abort "Publish Failed: File #{relative_path} already exists." if File.exist?(@path)

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

    def publish_path
      source = @config['source']
      name = "#{date_slug}-#{title_slug}.#{extension}"
      File.join(source, '_posts', name)
    end

    def read
      if @read_content
        @read_content
      else
        file = @options['path']
        abort "File #{file} not found." if !File.exist? file
        @read_content = Pathname.new(file).read
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
