module Octopress
  class Post < Page

    def set_default_options
      @options['type']      ||= 'post'
      @options['layout']      = @config['post_layout']
      @options['date']        = convert_date @options['date'] || Time.now
      @options['extension'] ||= @config['post_ext']
      @options['template']  ||= @config['post_template']
    end

    def path
      name = "#{date_slug}-#{title_slug}.#{extension}"
      File.join(source, '_posts', name)
    end

    # Returns a string which is url compatible.
    #
    def title_slug
      value = (@options['slug'] || @options['title']).downcase
      value.gsub!(/[^\x00-\x7F]/u, '')
      value.gsub!(/(&amp;|&)+/, 'and')
      value.gsub!(/[']+/, '')
      value.gsub!(/\W+/, ' ')
      value.strip!
      value.gsub!(' ', '-')
      value
    end

  end
end
