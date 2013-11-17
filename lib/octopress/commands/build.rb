module Octopress
  module Commands
    class Build
      def self.run(args, opts)
        Octopress.logger.debug("Executing build command")
        self.execute_jekyll(opts)
      end

      def self.execute_jekyll(opts)
        Jekyll::Commands::Build.process(Jekyll.configuration(opts))
      end
    end
  end
end
