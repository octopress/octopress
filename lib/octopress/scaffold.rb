module Octopress
  class Scaffold
    attr_reader :path, :force

    def initialize(args, options)
      @path  = File.expand_path(args.join(" "), Dir.pwd)
      @force = !!options['force']
    end
    
    def write
      if !force && (File.exist?(path + '/_templates') ||
        File.exist?(path + '/_octopress.yml'))
        abort "Some files already exist.  Use --force to overwrite."
      end

      FileUtils.cp_r scaffold_path + '/.', path

      puts "Octopress scaffold added to #{path}."
    end

    def scaffold_path
      Octopress.gem_dir('scaffold')
    end
    
  end
end
