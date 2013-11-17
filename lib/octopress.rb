require "octopress/version"
require "octopress/theme"

module Octopress
  def self.logger
    @logger ||= Logger.new(STDOUT)
    @logger.level = Logger::DEBUG
    @logger
  end
end
