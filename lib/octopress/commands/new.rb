require 'jekyll'

module Octopress
  class New < Command
    def self.init_with_program(p)
      p.command(:new) do |c|
        c.syntax 'new <PATH>'
        c.description 'Creates a new Jekyll site scaffold in path'
        c.option 'force', '--force', 'Force creation even if path already exists'
        c.option 'blank', '--blank', 'Creates scaffolding but with empty files'
        
        c.action do |args, options|
          if args.empty?
            c.logger.error "You must specify a path."
          else
            Jekyll::Commands::New.process(args, options.to_symbol_keys)
          end
        end

        c.command(:page) do |page_command|
          page_command.syntax 'page <PATH> [options]'
          page_command.description 'Add a new page to your Jekyll site.'
          page_command.option 'title', '--title TITLE', 'String to be added as the title in the YAML front-matter.'
          CommandHelpers.add_common_options page_command

          page_command.action do |args, options|
            options['path'] = args.first
            Page.new(options).write
          end
        end

        c.command(:post) do |post_command|
          post_command.syntax 'post <TITLE> [options]'
          post_command.description 'Add a new post to your Jekyll site.'
          post_command.option 'slug', '--slug', 'Use this slug in filename instead of sluggified post title'
          CommandHelpers.add_common_options post_command

          post_command.action do |args, options|
            options['title'] = args.first
            Post.new(options).write
          end
        end

        c.command(:draft) do |draft_command|
          draft_command.syntax 'draft <TITLE> [options]'
          draft_command.description 'Add a new draft post to your Jekyll site.'
          draft_command.option 'slug', '--slug', 'Use this slug in filename instead of sluggified post title'
          CommandHelpers.add_common_options draft_command

          draft_command.action do |args, options|
            options['title'] = args.first
            Draft.new(options).write
          end
        end
      end
    end
  end
end
