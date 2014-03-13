module Octopress
  class Post < Page

    def set_default_options
      @options['type'] ||= 'post'
      @options['layout'] =  @config['post_layout']
      @options['date'] = convert_date @options['date'] || Time.now
      @options['extension'] ||= @config['post_ext']
      @options['template'] ||= @config['post_template']
      raise "You must specify a title." if @options['title'].nil?
    end

    def path
      name = "#{date_slug}-#{title_slug}.#{extension}"
      File.join(source, '_posts', name)
    end
  end
end
