module Octopress
  class Scaffold
    attr_reader :path, :blank, :force

    def initialize(args, options)
      @path  = File.expand_path(args.join(" "), Dir.pwd)
      @blank = !!options['blank']
      @force = !!options['force']
    end
    
    def write
      if blank
        add_blank_scaffold
      else
        add_scaffold
      end

      puts "Octopress scaffold added to #{path}."
    end

    def add_blank_scaffold
      Dir.chdir(path) do
        FileUtils.mkdir_p('_templates')
        FileUtils.touch('_octopress.yml')
      end
    end

    def add_scaffold

      if File.exist?(path + '/_templates') ||
        File.exist?(path + '/_octopress.yml')
        abort "Some files already exist.  Use --force to overwrite." unless force
      end

      FileUtils.cp_r scaffold_path + '/.', path
    end

    def scaffold_path
      File.expand_path('../../scaffold', File.dirname(__FILE__))
    end
    
  end
end
