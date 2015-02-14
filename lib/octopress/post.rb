module Octopress
  class Post < Page

    def set_default_options
      @options['type']      ||= 'post'

      if @options['title'].nil? && @options[:type] == 'post'
        raise "Post not created: Please choose a title.\n".red + "  For example: " + "octopress new post \"Friendship with a tomato?\"".yellow
      end

      @options['layout']      = @config['post_layout']
      @options['date']        = convert_date @options['date']
      @options['extension'] ||= @config['post_ext']
      @options['template']  ||= @config['post_template']
      @options['dir']       ||= ''
    end

    def path
      name = "#{date_slug}-#{title_slug}.#{extension}"
      dir = File.join(site.source, '_posts', @options['dir'])
      FileUtils.mkdir_p dir
      File.join(dir, name)
    end

    def default_template
      'post'
    end
    
    def unpublish
      @options['date'] = read_post_yaml('date')
      @options['title'] = read_post_yaml('title')

      post_options = {
        'title'   => @options['title'],
        'date'    => @options['date'],
        'slug'    => title_slug,
        'content' => read_post_content,
        'dir'     => @options['dir'],
        'type'    => 'draft from post'
      }
      Draft.new(site, post_options).write     
      
      # Remove the old post file
      #
      FileUtils.rm @options['path']
    end

    # Reads the file from options[path]
    #
    def read
      @post_content ||= begin
        file = @options['path']
        raise "File #{file} not found." if !File.exist? file
        File.read(file)
      end
    end

    # Get title from post file
    #
    def read_post_yaml(key)
      match = read.match(/#{key}:\s*(.+)?$/)
      match[1] if match
    end
    
    # Get content from draft post file
    # also update the draft's date configuration
    #
    def read_post_content
      if @options['date']
        # remove date if it exists
        content = read.sub(/date:.*$\n/, "")
        
        # Insert date after title
        content.sub(/(title:.+$)/i, '\1'+"\ndate: #{@options['date']}")
      else
        read
      end
    end
    
  end
end
