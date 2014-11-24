module Octopress
  module Commands
    class Isolate < Command
      def self.init_with_program(p)
        p.command(:isolate) do |c|
          c.syntax 'isolate [search] [options]'
          c.description "Move posts to _posts/_exile if they do not match the search text or move the most recent post if search text is omitted."
          c.option 'path',   '--path [STRING]', 'Isolate a post at the specified path.'
          c.option 'config', '--config <CONFIG_FILE>[,CONFIG_FILE2,...]', Array, 'Custom Jekyll configuration file'

          c.action do |args, options|
            if !args.empty?
              options['search'] = args.first
            end
            Octopress::Isolate.new(options).process
          end
        end

        p.command(:integrate) do |c|
          c.syntax 'integrate'
          c.description "Reintegrate posts from _posts/_exile."
          c.option 'config', '--config <CONFIG_FILE>[,CONFIG_FILE2,...]', Array, 'Custom Jekyll configuration file'

          c.action do |args, options|
            Octopress::Isolate.new(options).revert
          end
        end
      end
    end
  end
end
