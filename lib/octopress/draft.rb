
module Octopress
  class Draft < Post

    def write
      super
      if @options['publish']
        FileUtils.rm @options['path']
      end
    end

    def set_default_options
      super
      if @options['publish']
        @options['title'] = read_title
        @options['type'] = 'post from draft' 
      else
        @options['type'] = 'draft' 
      end
    end

    def path
      if @options['publish']
        super
      else
        draft_path
      end
    end

    def draft_path
      source = @config['source']
      name = "#{title_slug}.#{extension}"
      File.join(source, '_drafts', name)
    end

    def read
      if @content
        @content
      else
        file = @options['path']
        abort "File #{file} not found." if !File.exist? file
        @content = Pathname.new(file).read
      end
    end

    def read_title
      read.match(/title:\s+(.+)?$/)[1]
    end
    
    def content
      if @options['publish']
        read.sub(/date:\s+.+?$/, "date: #{@options['date']}")
      else
        super
      end
    end
  end
end
