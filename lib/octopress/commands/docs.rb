require 'jekyll'
require 'yaml'
require File.expand_path('helpers', File.dirname(__FILE__))

module Octopress
  class Docs < Command
    def self.init_with_program(p)
      p.command(:docs) do |c|
        c.syntax 'octopress docs'
        c.description "Launch local server with docs for Octopress v#{Octopress::VERSION} and Octopress Ink plugins."

        c.option 'port', '-P', '--port [PORT]', 'Port to listen on'
        c.option 'host', '-H', '--host [HOST]', 'Host to bind to'
        if ENV['OCTODEV']
          c.option 'watch', '--watch', 'Watch docs site for changes and rebuild. (For docs development)'
        end
        c.option 'jekyll', '--jekyll', "Launch local server with docs for Jekyll v#{Jekyll::VERSION}"

        c.action do |args, options|
          serve_docs(options)
        end
      end
    end

    def self.serve_docs(options)
      if options['jekyll']
        options = init_jekyll_docs(options)
      else
        options = init_octopress_docs(options)
      end
      options["serving"] = true
      options = CommandHelpers.normalize_options(options)
      options = Jekyll.configuration(options.to_symbol_keys)
      Jekyll::Commands::Build.process(options)
      Jekyll::Commands::Serve.process(options)
    end

    def self.init_octopress_docs(options)
      Octopress.config({
        'octopress-config'=>File.join(site_dir, '_octopress.yml'),
        'override'=> { 'docs_mode'=>true }
      })
      require_gems
      options['source'] = site_dir
      options['destination'] = File.join(site_dir, '_site')
      options
    end

    def self.init_jekyll_docs(options)
      options.delete('jekyll')

      # Find local Jekyll gem path
      #
      spec = Gem::Specification.find_by_name("jekyll")
      gem_path = spec.gem_dir

      options['source'] = "#{gem_path}/site",
      options['destination'] = "#{gem_path}/site/_site"
      options
    end

    def self.site_dir
      File.expand_path('docs', File.join(File.dirname(__FILE__), '../../../', ))
    end

    def self.require_gems
      file = File.join(Dir.pwd, '_config.yml')
      if File.exist? file
        config = YAML.safe_load(File.open(file))
        gems = config['gems']
        if gems && gems.is_a?(Array)
          gems.each {|g| require g }
        end
      end
    end
  end
end
