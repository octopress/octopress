require 'pry-debugger'
module Octopress
  class Page

    def initialize(options)
      @config = Octopress.config(options)
      @options = options
      default_options
      write
    end

    def write
      abort "File #{path} already exists" if File.exist?(path)
      FileUtils.mkdir_p(File.dirname(path))
      File.open(path, 'w') { |f| f.write(template) }
    end

    def path
      File.join(@config['source'], "#{@options['path']}.#{@options['extension']}")
    end

    def extension
      @options['extension'].sub(/^\./, '')
    end

    def default_options
      @options['date'] = convert_date @options['date']
      @options['layout'] = 'page'
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
    def template
      file = @options['template']
      file = File.join(Octopress.site.source, file) if file
      if file 
        raise "No template found at #{file}" unless File.exist? file
        parse_template Pathname.new(file).read
      else
        parse_template default_template
      end
    end

    def parse_template(content)
      template = Liquid::Template.parse(content)
      content = template.render(@options)
    end

    # Page template defaults
    #
    def default_template
      <<-TEMPLATE
---
layout: {{ layout }}
title: {{ title }}
---
TEMPLATE
    end
  end
end
