require 'jekyll'
require 'pry-debugger'

module Octopress
  class New < Command
    def self.init_with_program(p)
      p.command(:new) do |c|
        c.syntax 'octopress new TYPE PATH [options]'
        c.description 'Add a new page, post or draft to your Jekyll site.'
        c.option 'draft', '--draft', 'Should the post be created as a draft'
        c.option 'date', '--date DATE', 'String that is parseable by Time#parse. (default: Time.now.iso8601)'
        c.option 'template', '--template PATH', 'Path to a post or page template.'
        
        c.action do |_, options|
          args = c.parent.optparse.default_argv
          if args[0] == 'page'
            options['path'] = args[1]
            Page.new(options)
          elsif args[0] == 'post'
            options['title'] = args[1]
            Post.new(options)
          else
            abort "You must specify a path." if args.empty?
            ::Jekyll::Commands::New.process(args, options)
          end
        end
      end
    end
  end
end
