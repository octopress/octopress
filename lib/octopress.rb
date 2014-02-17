module Octopress
  require 'octopress/command'
  require 'octopress/version'
  require 'octopress/commands/new'
  autoload :Page, 'octopress/page'
  autoload :Post, 'octopress/post'

  BLESSED_GEMS = %w[
    octopress-deploy
    octopress-ink
  ]

  DEFAULTS = { 'octopress' => {
    'new_post_extension' => 'markdown',
    'new_page_extension' => 'html',
    'new_post_layout' => 'post',
    'new_page_layout' => 'page',
    'titlecase' => true
  }}

  def self.logger
    @logger ||= Logger.new(STDOUT)
    @logger.level = Logger::DEBUG
    @logger
  end

  def self.site(options={})
    @site ||= Jekyll::Site.new(config(options))
  end

  def self.config(options={})
    log_level = Jekyll.logger.log_level
    Jekyll.logger.log_level = Jekyll::Stevenson::WARN
    @config ||= DEFAULTS.deep_merge Jekyll.configuration(options)
    Jekyll.logger.log_level = log_level
    @config
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
