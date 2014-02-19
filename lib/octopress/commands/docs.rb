require 'jekyll'
require File.expand_path('helpers', File.dirname(__FILE__))

module Octopress
  class Docs < Command
    def self.init_with_program(p)
      p.command(:docs) do |c|
        c.syntax 'octopress docs'
        c.description "Soon: Launch local server with docs for Octopress v#{Octopress::VERSION}"

        c.option 'port', '-P', '--port [PORT]', 'Port to listen on'
        c.option 'host', '-H', '--host [HOST]', 'Host to bind to'
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

            options = CommandHelpers.normalize_options(options)
            options = ::Jekyll.configuration(options.to_symbol_keys.merge!({
              'source' => "#{gem_path}/site",
              'destination' => "#{gem_path}/site/_site"
            }))
            
            ::Jekyll::Commands::Build.process(options)
            ::Jekyll::Commands::Serve.process(options)
          else
            puts "Sorry, not yet. View Octopress docs on http://octopress.org or view Jekyll docs locally by running `octopress docs --jekyll`"
          end
        end
      end
    end
  end
end
