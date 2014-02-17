module Octopress
  class Publish < Command
    def self.init_with_program(p)
      p.command(:publish) do |c|
        c.syntax 'octopress publish PATH [options]'
        c.description 'Convert a draft to a normal published post.'
        c.option 'date', '--date DATE', 'String that is parseable by Time#parse. (default: Time.now.iso8601)'

        c.action do |args, options|
          abort "You must specify a path." if args.empty?
          options['path'] = args.first
          options['publish'] = true
          Draft.new(options).write
        end
      end
    end
  end
end

