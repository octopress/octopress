module Octopress
  class Post < Page

    def set_default_options
      @options['type']      ||= 'post'
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
    
    # Post template defaults
    #
    def default_content
      front_matter %w{layout title date}
    end

  end
end
