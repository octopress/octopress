module Octopress
  class Serve < Command
    def self.init_with_program(p)
      p.command(:serve) do |c|
        c.alias(:server)

        c.syntax 'serve [options]'
        c.description 'Serve your site locally'

        CommandHelpers.add_build_options(c)

        c.option 'detach', '-B', '--detach',      'Run the server in the background (detach)'
        c.option 'port',   '-P', '--port PORT',   'Port to listen on'
        c.option 'host',   '-H', '--host HOST',   'Host to bind to'
        c.option 'baseurl',      '--baseurl URL', 'Base URL'

        c.action do |args, options|
          Octopress.config(options)
          options["serving"] ||= true

          options = CommandHelpers.normalize_options(options)
          options = Jekyll.configuration(options)
          Jekyll::Commands::Build.process(options)
          Jekyll::Commands::Serve.process(options)
        end
      end
    end
  end
end

