module Octopress
  class Draft < Post

    def set_default_options
      @options['type']      ||= 'draft' 
      @options['layout']      = @config['post_layout']
      @options['dir']       ||= ''
      @options['extension'] ||= @config['post_ext']
      @options['template']  ||= @config['post_template']

      if @options['date']
        @options['date'] = convert_date @options['date']
      end
    end

    def path
      name = "#{title_slug}.#{extension}"
      File.join(site.source, '_drafts', name)
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
      @options['date'] ||= read_draft_date || Time.now.iso8601

      post_options = {
        'title'   => read_draft_title,
        'date'    => @options['date'],
        'slug'    => publish_slug,
        'content' => read_draft_content,
        'dir'     => @options['dir'],
        'type'    => 'post from draft'
      }

      # Create a new post file
      #
      Post.new(site, post_options).write
      
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
        @draft_content = File.read(file)
      end
    end

    # Get title from draft post file
    #
    def read_draft_title
      match = read.match(/title:\s+(.+)?$/)
      match[1] if match
    end
    
    # read_draft_date
    #
    def read_draft_date
      match = read.match(/date:\s+(\d.+)$/)
      match[1] if match
    end
    
    # Get content from draft post file
    # also update the draft's date configuration
    #
    def read_draft_content
      if @options['date']
        # remove date if it exists
        content = read.sub(/date:.*$\n/, "")
        
        # Insert date after title
        content.sub(/(title:.+$)/i, '\1'+"\ndate: #{@options['date']}")
      else
        read
      end
    end
    
    def default_template
      'draft'
    end

    # Draft template defaults
    #
    def default_content

      if @options['date']
        front_matter %w{layout title date}
      else
        front_matter %w{layout title}
      end
    end
  end
end
