module Octopress
  class Page

    def initialize(options)
      @config = Octopress.config(options)
      @options = options
      set_default_options
      @content = options['content'] || content
    end

    def write
      if File.exist?(path) && !@options['force']
        raise "File #{relative_path} already exists. Use --force to overwrite."
      end

      FileUtils.mkdir_p(File.dirname(path))
      File.open(path, 'w') { |f| f.write(@content) }
      if STDOUT.tty?
        puts "New #{@options['type']}: #{relative_path}"
      else
        puts path
      end
    end

    def relative_path
      local = Dir.pwd + '/'
      path.sub(local, '')
    end

    def source
      Configuration.jekyll_config(@options)['source']
    end

    def path
      return @path if @path
      file = @options['path']
      raise "You must specify a path." unless file

      # If path ends with a slash, make it an index
      file += "index" if file =~ /\/$/

      # if path has no extension, add the default extension
      file += ".#{extension}" unless file =~ /\.\w+$/

      @path = File.join(source, file)
    end

    def extension
      @options['extension'].sub(/^\./, '')
    end

    def set_default_options
      @options['type'] ||= 'page'
      @options['layout']      =  @config['new_page_layout']
      @options['date']        = convert_date @options['date']
      @options['extension'] ||= @config['page_extension']
      @options['template'] ||= @config['page_template']
    end

    def convert_date(date)
      if date
        begin
          Time.parse(date.to_s).iso8601
        rescue => error
          abort 'Could not parse date. Try formatting it like YYYY-MM-DD HH:MM'
        end
      end
    end

    # Load the user provide or default template for a new post.
    #
    def content
      file = @options['template']
      file = File.join(source, '_templates', file) if file
      if file 
        abort "No #{@options['type']} template found at #{file}" unless File.exist? file
        parse_template Pathname.new(file).read
      else
        parse_template default_content
      end
    end

    # Render Liquid vars in YAML front-matter.
    def parse_template(input)

      # If possible only parse the YAML front matter.
      # If YAML front-matter dashes aren't present parse the whole 
      # template and add dashes.
      #
      parsed = if input =~ /\A-{3}\s+(.+?)\s+-{3}\s+(.+)/m
        template = Liquid::Template.parse($1)
        "---\n#{template.render(@options)}\n---\n\n#{$2}"
      else
        template = Liquid::Template.parse(input)
        "---\n#{template.render(@options)}\n---\n\n"
      end
    end

    def date_slug
      Time.parse(@options['date']).strftime('%Y-%m-%d')
    end

    # Returns a string which is url compatible.
    #
    def title_slug
      value = @options['slug'] || @options['title']
      value.gsub(/[^\x00-\x7F]/u, '')
      value.gsub!(/(&amp;|&)+/, 'and')
      value.gsub!(/[']+/, '')
      value.gsub!(/\W+/, ' ')
      value.strip!
      value.downcase!
      value.gsub!(' ', '-')
      value
    end

    # Page template defaults
    #
    def default_content
      <<-TEMPLATE
---
layout: {{ layout }}
title: {{ title }}
---
TEMPLATE
    end
  end
end
