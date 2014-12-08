module Octopress
  class Page

    def initialize(options)
      @config = Octopress.config(options)
      @options = options
      set_default_options

      # Ensure title
      #
      @options['title'] ||= ''

      # Ensure a quoted title
      #
      @options['title'] = "\"#{@options['title']}\""

      @content = options['content'] || content
    end

    def write
      if File.exist?(path) && !@options['force']
        raise "File #{relative_path(path)} already exists. Use --force to overwrite."
      end

      dir = File.dirname(path)

      FileUtils.mkdir_p(dir)
      File.open(path, 'w') { |f| f.write(@content) }
      if STDOUT.tty?
        puts "New #{@options['type']}: #{relative_path(path)}"
        
        # If path begins with an underscore the page is probably being added to a collection
        #
        print_collection_tip($1) if dir =~ /#{source}\/_([^\/]+)/
      else
        puts path
      end
    end

    # Print instructions for setting up a new collection
    #
    def print_collection_tip(collection)
      # If Jekyll is not already configurated for this collection, print instructions
      #
      if !jekyll_config['collections'] || !jekyll_config['collections'][collection]
        msg = "\nTIP: To create a new '#{collection}' collection, add this to your Jekyll configuration\n"
        msg += "----------------\n"
        msg += "collections:\n  #{collection}:\n    output: true"
        msg += "\n----------------"
        puts msg
      end
    end

    def relative_path(path)
      local = Dir.pwd + '/'
      path.sub(local, '')
    end

    def jekyll_config
      Configuration.jekyll_config(@options)
    end

    def source
      jekyll_config['source']
    end

    def path
      return @path if @path
      file = @options['path']
      raise "You must specify a path." unless file

      # If path ends with a slash, make it an index
      #
      file += "index" if file =~ /\/$/

      # if path has no extension, add the default extension
      #
      file += ".#{extension}" unless file =~ /\.\w+$/

      @path = File.join(source, file)
    end

    def extension
      @options['extension'].sub(/^\./, '')
    end

    def set_default_options
      @options['type']      ||= 'page'
      @options['layout']      = @config['page_layout']
      if @options['date']
        @options['date']        = convert_date @options['date']
      end
      @options['extension'] ||= @config['page_ext']
      @options['template']  ||= @config['page_template']
    end

    def convert_date(date)
      date ||= 'now'
      if date == 'now'
        @options['date'] = Time.now.iso8601
      else
        begin
          Time.parse(date.to_s, Time.now).iso8601
        rescue => error
          puts 'Could not parse date. Try formatting it like YYYY-MM-DD HH:MM'
          abort error.message
        end
      end
    end

    # Load the user provided or default template for a new post or page.
    #
    def content

      # Handle case where user passes the full path
      #
      file = @options['template'] || default_template

      if file
        file.sub(/^_templates\//, '')
        file = File.join(source, '_templates', file) if file
        if File.exist? file
          parse_template File.open(file).read
        elsif @options['template']
          abort "No #{@options['type']} template found at #{file}"
        else
          parse_template default_content
        end
      else
        parse_template default_content
      end
    end

    def default_template
      'page'
    end

    # Render Liquid vars in YAML front-matter.
    def parse_template(input)

      if @config['titlecase']
        @options['title'].titlecase!
      end
      # If possible only parse the YAML front matter.
      # If YAML front-matter dashes aren't present parse the whole 
      # template and add dashes.
      #

      parsed = if input =~ /\A-{3}\s+(.+?)\s+-{3}(.+)?/m
        input = $1
        content = $2
        if @options['date'] && !(input =~ /date:/)
          input += "\ndate: #{@options['date']}"
        end
      else
        content = ''
      end

      template = Liquid::Template.parse(input)
      "---\n#{template.render(@options).strip}\n---\n#{content}"
    end

    def date_slug
      @options['date'].split('T')[0]
    end

    def front_matter(vars)
      fm = []
      vars.each do |v| 
        fm << "#{v}: {{ #{v} }}" if @options[v]
      end
      fm.join("\n")
    end

    # Page template defaults
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
