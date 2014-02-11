module Octopress
  autoload :Command, 'octopress/command'
  autoload :VERSION, 'octopress/version'

  BLESSED_GEMS = %w[
    octopress-deploy
  ]

  def self.logger
    @logger ||= Logger.new(STDOUT)
    @logger.level = Logger::DEBUG
    @logger
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
