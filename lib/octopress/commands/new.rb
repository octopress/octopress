require 'jekyll'

module Octopress
  class New < Command
    def self.init_with_program(p)
      p.command(:new) do |c|
        c.syntax 'octopress new <page or post> <PATH or TITLE> [options]'
        c.description 'Add a new page, post or draft to your Jekyll site.'
        c.option 'draft', '--draft', 'Should the post be created as a draft'
        c.option 'date', '--date DATE', 'String that is parseable by Time#parse. (default: Time.now.iso8601)'
        c.option 'template', '--template PATH', 'Path to a post or page template.'
        
        c.action do |args, options|
          case args.first
          when 'page'
            options['path'] = args.last
            Page.new(options).write
          when 'post'
            options['title'] = args.last
            Post.new(options).write
          else
            abort "You must specify a path." if args.empty?
            ::Jekyll::Commands::New.process(args, options)
          end
        end
      end
    end
  end
end
