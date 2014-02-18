module Octopress
  require 'octopress/core_ext'
  require 'octopress/configuration'
  require 'octopress/command'
  require 'octopress/version'
  require 'octopress/commands/new'
  require 'octopress/commands/publish'

  autoload :Page, 'octopress/page'
  autoload :Post, 'octopress/post'
  autoload :Draft, 'octopress/draft'

  BLESSED_GEMS = %w[
    octopress-deploy
    octopress-ink
  ]

  def self.logger
    @logger ||= Logger.new(STDOUT)
    @logger.level = Logger::DEBUG
    @logger
  end

  def self.config(options={})
    Configuration.config(options)
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
