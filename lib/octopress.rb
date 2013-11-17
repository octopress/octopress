this_dir = File.dirname(__FILE__)
$LOAD_PATH.unshift(this_dir) unless $LOAD_PATH.include?(this_dir)

def require_all(rel_dir)
  path = File.expand_path(File.join(rel_dir, "*.rb"), File.dirname(__FILE__))
  Dir[path].each { |f| require f }
end

# Octopress
require "octopress/version"
require "octopress/theme"
require_all "octopress/commands"


module Octopress
  def self.logger
    @logger ||= Logger.new(STDOUT)
    @logger.level = Logger::DEBUG
    @logger
  end
end
