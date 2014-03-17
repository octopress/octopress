module Octopress
  class Scaffold
    attr_reader :path, :force

    def initialize(args, options)
      @path  = File.expand_path(args.join(" "), Dir.pwd)
      @force = !!options['force']
    end
    
    def write
      if File.exist?(path + '/_templates') ||
        File.exist?(path + '/_octopress.yml')
        abort "Some files already exist.  Use --force to overwrite." unless force
      end

      FileUtils.cp_r scaffold_path + '/.', path

      puts "Octopress scaffold added to #{path}."
    end

    def scaffold_path
      File.expand_path('../../scaffold', File.dirname(__FILE__))
    end
    
  end
end
