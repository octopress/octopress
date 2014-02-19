require 'jekyll'
require File.expand_path('helpers', File.dirname(__FILE__))

module Octopress
  class Build < Command
    def self.init_with_program(p)
      p.command(:build) do |c|
        c.syntax 'octopress build [options]'
        c.description 'Build your site'
        Helpers.add_build_options(c)
        
        c.action do |args, options|
          options = Helpers.normalize_options(options)
          options = ::Jekyll.configuration(options.to_symbol_keys)
          ::Jekyll::Commands::Build.process(options)
        end
      end
    end
  end
end

