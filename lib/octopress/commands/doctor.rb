module Octopress
  class Doctor < Command
    def self.init_with_program(p)
      p.command(:doctor) do |c|
        c.alias(:hyde)

        c.syntax 'doctor'
        c.description 'Search site and print specific deprecation warnings'
        CommandHelpers.add_common_options c

        c.action do |args, options|
          options = CommandHelpers.normalize_options(options)
          options = Jekyll.configuration(options.to_symbol_keys)
          Jekyll::Commands::Doctor.process(options)
        end
      end
    end
  end
end

