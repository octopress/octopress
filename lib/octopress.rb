require 'mercenary'
require 'titlecase'

module Octopress
  require 'octopress/command'
  require 'octopress/version'
  require 'octopress/utils'
  require 'octopress/commands/new'
  require 'octopress/commands/docs'
  require 'octopress/commands/init'
  require 'octopress/commands/publish'
  require 'octopress/commands/unpublish'
  require 'octopress/commands/isolate'
  require 'octopress/isolate'
  require 'octopress/docs'

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
    if site?
      @site.config
    else
      @config ||= Jekyll.configuration(options)
    end
  end

  def self.site?
    !@site.nil?
  end

  # Cache Jekyll's site
  #
  def self.site(options={})
    @site ||= read_site(options)
  end

  # Quietly read from Jekyll's site
  #
  def self.read_site(options={})
    Jekyll.logger.log_level = :error
    s = Jekyll::Site.new(Jekyll.configuration(options))
    Jekyll.logger.log_level = :info
    alias_site_title(s)
  end

  # Allow site to be set
  #
  def self.site=(site)
    @site = alias_site_title(site)
  end

  # Octopress historically used site.title
  # This ensures we can all use site.name to be
  # compatible with Jekyll's scaffold convention
  #
  def self.alias_site_title(site)
    site.config['name'] ||= site.config['title']
    site
  end

  def self.gem_dir(dir='')
    File.expand_path(File.join(File.dirname(__FILE__), '..', dir))
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

Octopress::Docs.add({
  name:        "Octopress",
  gem:         "octopress",
  version:     Octopress::VERSION,
  description: "A framework for writing Jekyll sites ",
  base_url:    "octopress",
  path:        File.expand_path(File.join(File.dirname(__FILE__), "..")),
  source_url:  "https://github.com/octopress/octopress",
  website:     "http://octopress.org",
})

Octopress.require_blessed_gems

