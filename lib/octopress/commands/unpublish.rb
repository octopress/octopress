module Octopress
  class Unpublish < Command
    def self.init_with_program(p)
      p.command(:unpublish) do |c|
        c.syntax 'unpublish <SEARCH> [options]'
        c.description 'Find a post using the search string and convert the post to a draft.'
        c.option 'force', '--force', 'Overwrite file if it already exists'
        c.option 'path', '--path <Path>', 'Select a post by path instead of search string.'
        CommandHelpers.add_common_options c

        c.action do |args, options|
          options['search'] = args.first
          options['type'] = 'draft from post'

          if options['search']
            find_posts(options)
          else
            if !options['path']
              abort "You must provide a search string or specify a path.\nFor more info run: octopress unpublish --help"
            end
            Post.new(Octopress.site(options), options).unpublish
          end
        end
      end
    end

    def self.find_posts(options)
      posts = Utils.find_posts.select do |p|
        p =~ /#{options['search'].gsub(/\s/, '-')}/i 
      end

      if posts.empty?
        if STDOUT.tty?
          abort "No posts found with search: #{options['search']}"
        else
          abort
        end
      elsif posts.size > 1
        choose_post(posts, options)
      else
        options['path'] = posts.first
        unpublish_post(options)
      end
    end

    def self.choose_post(posts, options)
      if STDOUT.tty?
        puts "Found #{posts.size} posts matching: '#{options['search']}'"
        posts.each_with_index do |p, i| 
          post = p.sub(Octopress.site.source + '/_posts/', '')
          puts "  #{i+1}) #{post}"
        end

        print "Which do you want to unpublish? (enter a number): "
        $stdout.flush
        post = gets.strip.to_i

        if post and post.is_a? Integer
          options['path'] = posts[post - 1]
          unpublish_post(options)
        else
          abort "Unpublished canceled: You didn't enter number."
        end

      else
        abort
      end
    end

    def self.unpublish_post(options)
      Post.new(Octopress.site(options), options).unpublish
    end
  end
end

