require 'jekyll'
require File.expand_path('helpers', File.dirname(__FILE__))

module Octopress
  class Doctor < Command
    def self.init_with_program(p)
      p.command(:doctor) do |c|
        c.alias(:hyde)

        c.syntax 'octopress doctor'
        c.description 'Search site and print specific deprecation warnings'

        c.option 'config', '--config CONFIG_FILE[,CONFIG_FILE2,...]', Array, 'Custom configuration file'

        c.action do |args, options|
          options = CommandHelpers.normalize_options(options)
          options = Jekyll.configuration(options.to_symbol_keys)
          ::Jekyll::Commands::Doctor.process(options)
        end
      end
    end
  end
end

