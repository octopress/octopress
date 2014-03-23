module Octopress
  class CLIDocs < Octopress::Ink::Plugin
    def configuration
      {
        name:        "Octopress",
        description: "An obsessively designed framework for Jekyll sites.",
        slug:        "cli",
        assets_path: Octopress.gem_dir('assets'),
        version:     Octopress::VERSION
      }
    end

    def docs_base_path
      'docs/cli'
    end

    def info(options)
      if options['docs']
        super
      else
        ''
      end
    end
  end
end
