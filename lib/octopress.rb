require 'mercenary'
require 'titlecase'

module Octopress
  require 'octopress/command'
  require 'octopress/version'
  require 'octopress/commands/new'
  require 'octopress/commands/init'
  require 'octopress/commands/publish'
  require 'octopress/commands/isolate'
  require 'octopress/isolate'

  autoload :Page, 'octopress/page'
  autoload :Post, 'octopress/post'
  autoload :Draft, 'octopress/draft'
  autoload :Scaffold, 'octopress/scaffold'

  # Automatically require these gems if installed
  BLESSED_GEMS = %w[
    octopress-ink
    octopress-deploy
  ]

  def self.logger
    @logger ||= Mercenary::Command.logger
    @logger.level = Logger::DEBUG
    @logger
  end

  # Cache Jekyll's site configuration
  #
  def self.configuration(options={})
    if @site
      @site.config
    else
      @config ||= Jekyll.configuration(options)
    end
  end

  # Cache Jekyll's site
  #
  def self.site(options={})
    if !@site
      Jekyll.logger.log_level = :error
      @site = Jekyll::Site.new(configuration(options))
      Jekyll.logger.log_level = :info
    end
    @site
  end

  # Allow site to set
  #
  def self.site=(site)
    # Octopress historically used site.title
    # This allows theme developers to expect site.name
    # in consistancy with Jekyll's scaffold config 
    site.config['name'] ||= site.config['title']

    @site = site
  end

  def self.gem_dir(dir='')
    File.expand_path(File.join(File.dirname(__FILE__), '../', dir))
  end

  def self.require_blessed_gems
    BLESSED_GEMS.each do |gem|
      begin
        require gem
      rescue LoadError
      end
    end
  end
end

require 'octopress-docs'

Octopress::Docs.add({
  name:        "Octopress",
  base_url:    "/octopress",
  path:        File.expand_path(File.join(File.dirname(__FILE__), "../")),
})

Octopress.require_blessed_gems

