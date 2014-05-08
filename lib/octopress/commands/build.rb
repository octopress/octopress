module Octopress
  class Build < Command
    def self.init_with_program(p)
      p.command(:build) do |c|
        c.syntax 'build [options]'
        c.description 'Build your site'
        CommandHelpers.add_build_options(c)
        
        c.action do |args, options|
          Octopress.config(options)
          options = CommandHelpers.normalize_options(options)
          options = ::Jekyll.configuration(options)
          ::Jekyll::Commands::Build.process(options)
        end
      end
    end
  end
end

