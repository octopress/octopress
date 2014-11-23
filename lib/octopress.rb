require 'mercenary'
require 'titlecase'

module Octopress
  require 'octopress/configuration'
  require 'octopress/command'
  require 'octopress/version'
  require 'octopress/commands/new'
  require 'octopress/commands/init'
  require 'octopress/commands/publish'

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

  def self.config(options={})
    @config ||= Configuration.config(options)
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
  name:        "Octopress CLI",
  slug:        "octopress",
  base_url:    "/octopress",
  dir:         File.expand_path(File.join(File.dirname(__FILE__), "../")),
})

Octopress.require_blessed_gems

