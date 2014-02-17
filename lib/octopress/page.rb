module Octopress
  class Page

    attr_accessor :content

    def initialize(options)
      @config = Octopress.config(options)
      @options = options
      set_default_options
      @content = options['content'] || read_content
      @path = path
    end

    def write
      abort "File #{relative_path} already exists" if File.exist?(@path)
      FileUtils.mkdir_p(File.dirname(@path))
      File.open(@path, 'w') { |f| f.write(@content) }
      if STDOUT.tty?
        puts "New #{@options['type']}: #{relative_path}"
      else
        puts @path
      end
    end

    def relative_path
      local = Dir.pwd + '/'
      @path.sub(local, '')
    end

    def path
      File.join(@config['source'], "#{@options['path']}.#{extension}")
    end

    def extension
      @options['extension'].sub(/^\./, '')
    end

    def set_default_options
      @options['type'] = 'page'
      @options['layout']      =  @config['octopress']['new_page_layout']
      @options['date']        = convert_date @options['date']
      @options['extension'] ||= @config['octopress']['new_page_extension']
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
    def read_content
      file = @options['template']
      file = File.join(Octopress.site.source, file) if file
      if file 
        raise "No template found at #{file}" unless File.exist? file
        parse_template Pathname.new(file).read
      else
        parse_template default_content
      end
    end

    def parse_template(input)
      template = Liquid::Template.parse(input)
      template.render(@options)
    end

    def date_slug
      Time.parse(@options['date']).strftime('%Y-%m-%d')
    end

    # Returns a string which is url compatible.
    #
    def title_slug
      value = @options['title'].gsub(/[^\x00-\x7F]/u, '')
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
