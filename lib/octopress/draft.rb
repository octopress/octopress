module Octopress
  class Draft < Post

    def set_default_options
      super
      @options['type'] = 'draft' 
    end

    def path
      name = "#{title_slug}.#{extension}"
      File.join(source, '_drafts', name)
    end

    # -----
    # Methods for publishing drafts
    # -----

    # Create a new post from draft file
    #
    # Sets post options based on draft file contents
    # and options passed to the publish command
    #
    def publish

      post_options = {
        'title'   => read_draft_title,
        'slug'    => publish_slug,
        'content' => read_draft_content,
        'type'    => 'post from draft'
      }

      # Create a new post file
      #
      Post.new(post_options).write
      
      # Remove the old draft file
      #
      FileUtils.rm @options['path']

    end

    # Get the slug from options or filename
    #
    def publish_slug
      @options['slug'] || File.basename(@options['path'], '.*')
    end

    # Reads the file from _drafts/[path]
    #
    def read
      if @draft_content
        @draft_content
      else
        file = @options['path']
        abort "File #{file} not found." if !File.exist? file
        @draft_content = File.open(file).read
      end
    end

    # Get title from draft post file
    #
    def read_draft_title
      read.match(/title:\s+(.+)?$/)[1]
    end
    
    # Get content from draft post file
    #
    def read_draft_content
      read.sub(/date:\s+.+?$/, "date: #{@options['date']}")
    end

  end
end
