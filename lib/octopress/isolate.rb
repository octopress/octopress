require 'find'

module Octopress
  class Isolate
    attr_accessor :site

    def initialize(options)
      @options = options
      @site = Octopress.site(@options)
    end

    def revert
      dir = File.join(site.source, '_posts')
      exile_dir = File.join(dir, '_exile')
      if Dir.exist?(exile_dir)
        posts = find_exiled_posts
        if posts.size > 0
          FileUtils.mv(posts, dir)
          FileUtils.rmdir(File.join(dir, '_exile'))

          puts "Reintegrated #{posts.size} post#{'s' if posts.size != 1} from _posts/_exile"
        else
          puts "There aren't any posts in _posts/_exile."
        end
      else
        puts "There aren't any posts in _posts/_exile."
      end
    end

    def process

      if @options['path']
        path = File.join(site.source, @options['path'])
        if File.exist? path
          isolate_except(path)
        else
          puts "File not found: #{@options['path']}"
        end
      elsif @options['search']
        isolate_search(@options['search'])
      else
        isolate_latest
      end
    end

    # remove all posts that do not match string
    def isolate_search(string)
      posts = Utils.find_posts.select { |p| p =~ /#{string.gsub(/\s/, '-')}/i }
      isolate_except(posts)
    end

    # Isolate all but the most recent post
    def isolate_latest
      post = site.read_posts('').sort_by(&:date).last
      path = File.join(site.source, post.path)
      isolate_except(path)
    end

    def isolate_except(posts)
      others = find_other_posts(posts)
      posts = default_array(posts)
      exile_dir = site.source, '_posts/_exile'


      if posts.size > 0
        FileUtils.mkdir_p(exile_dir)
        FileUtils.mv(others, exile_dir)

        puts "Isolated #{posts.size} post#{'s' if posts.size != 1}:"
        posts.each do |p|
          puts "  - #{p.sub(site.source+'/_posts/', '')}" 
        end
        puts "Moved #{others.size} post#{'s' if others.size != 1} into _posts/_exile"
      else
        puts "No matching posts were found."
      end
    end

    def find_other_posts(paths)
      paths = default_array(paths)

      Utils.find_posts.reject do |p| 
        paths.include?(p)
      end
    end

    def find_posts
      Utils.find_posts.reject { |f| f =~ /_exile\// }
    end

    def find_exiled_posts
      Utils.find_posts.select { |f| f =~ /_exile\// }
    end

    def default_array(input)
      i = input || []
      i = [i] unless i.is_a?(Array)
      i
    end

  end
end
