require 'jekyll'
require 'pry-debugger'

module Octopress
  class New < Command
    def self.init_with_program(p)
      p.command(:new) do |c|

        c.action do |args, options|
          abort "You must specify a path." if args.empty?
          ::Jekyll::Commands::New.process(args, options)
        end

        c.command(:page) do |page_command|
          page_command.syntax 'octopress new page PATH [options]'
          page_command.description 'Add a new page to your Jekyll site.'
          page_command.option 'title', '--title TITLE', 'String to be added as the title in the YAML front-matter.'
          add_common_options page_command

          page_command.action do |args, options|
            abort "You must specify a path." if args.empty?
            options['path'] = args.first
            Page.new(options).write
          end
        end

        c.command(:post) do |post_command|
          post_command.syntax 'octopress new post TITLE [options]'
          post_command.description 'Add a new post to your Jekyll site.'
          add_common_options post_command

          post_command.action do |args, options|
            options['title'] = args.first
            Post.new(options).write
          end
        end

        c.command(:draft) do |draft_command|
          draft_command.syntax 'octopress new draft TITLE [options]'
          draft_command.description 'Add a new draft post to your Jekyll site.'
          add_common_options draft_command

          draft_command.action do |args, options|
            options['title'] = args.first
            Draft.new(options).write
          end
        end
      end
    end
    def self.add_common_options(c)
      c.option 'date', '--date DATE', 'String that is parseable by Time#parse. (default: Time.now.iso8601)'
      c.option 'template', '--template PATH', 'Path to a post or page template.'
    end
  end
end
