module Octopress
  class Draft < Post

    def set_default_options
      @options['type']      ||= 'draft' 

      if @options['title'].nil? && @options[:type] == 'post'
        raise "Draft not created: Please choose a title.\n".red + "  For example: " + "octopress new draft 'The merits of napping'".yellow
      end

      @options['layout']      = @config['post_layout']
      @options['dir']       ||= ''
      @options['extension'] ||= @config['post_ext']
      @options['template']  ||= @config['draft_template']

      if @options['date']
        @options['date'] = convert_date @options['date']
      end
    end

    def path
      name = "#{title_slug}.#{extension}"
      File.join(site.source, '_drafts', name)
    end

    # Create a new post from draft file
    #
    # Sets post options based on draft file contents
    # and options passed to the publish command
    #
    def publish
      @options['date'] ||= read_post_yaml('date') || Time.now.iso8601
      @options['title'] = read_post_yaml('title')

      post_options = {
        'title'   => @options['title'],
        'date'    => @options['date'],
        'slug'    => title_slug,
        'content' => read_post_content,
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

    def default_template
      'draft'
    end
  end
end
