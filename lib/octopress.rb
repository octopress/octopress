module Octopress
  autoload :Command, 'octopress/command'
  autoload :VERSION, 'octopress/version'

  def self.logger
    @logger ||= Logger.new(STDOUT)
    @logger.level = Logger::DEBUG
    @logger
  end
end
