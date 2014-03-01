require 'jekyll'
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
          
          # Only show jekyll docs if the jekyll flag was used
          #
          if options['jekyll']
            options.delete('jekyll')

            # Find local Jekyll gem path
            #
            spec = Gem::Specification.find_by_name("jekyll")
            gem_path = spec.gem_dir

            options['source'] = "#{gem_path}/site",
            options['destination'] = "#{gem_path}/site/_site"
          else
            options['source'] = site_dir
            options['destination'] = File.join(site_dir, '_site')
            Octopress.config({'octopress-config'=>File.join(site_dir, '_octopress.yml')})
          end

          options["serving"] = true
          options = CommandHelpers.normalize_options(options)
          options = ::Jekyll.configuration(options.to_symbol_keys)
          ::Jekyll::Commands::Build.process(options)
          ::Jekyll::Commands::Serve.process(options)
        end
      end
    end
    def self.site_dir
      File.expand_path('docs', File.join(File.dirname(__FILE__), '../../../', ))
    end
  end
end
