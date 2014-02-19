require 'jekyll'
require File.expand_path('helpers', File.dirname(__FILE__))

module Octopress
  class Docs < Command
    def self.init_with_program(p)
      p.command(:docs) do |c|
        c.syntax 'octopress docs'
        c.description "Launch local server with docs for Jekyll v#{Jekyll::VERSION}"

        c.option 'port', '-P', '--port [PORT]', 'Port to listen on'
        c.option 'host', '-H', '--host [HOST]', 'Host to bind to'

        c.action do |args, options|

          # Find local Jekyll gem path
          spec = Gem::Specification.find_by_name("jekyll")
          gem_path = spec.gem_dir

          options = Helpers.normalize_options(options)
          options = ::Jekyll.configuration(options.to_symbol_keys.merge!({
            'source' => "#{gem_path}/site",
            'destination' => "#{gem_path}/site/_site"
          }))
          ::Jekyll::Commands::Build.process(options)
          ::Jekyll::Commands::Serve.process(options)
        end
      end
    end
  end
end
