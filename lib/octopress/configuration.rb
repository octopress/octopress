module Octopress
  module Configuration

    DEFAULTS = {
      'post_extension' => 'markdown',
      'page_extension' => 'html',
      'post_layout' => 'post',
      'page_layout' => 'page',
      'titlecase' => true
    }

    def self.config(options={})
      return @config if @config

      file = options['config-file'] || '_octopress.yml'
      user_config = {}

      if File.exist? file
        user_config = YAML.safe_load(File.open(file))
      end

      user_config = user_config.deep_merge(options['override'] || {})
      user_config = (options['defaults'] || {}).deep_merge(user_config)

      @config = DEFAULTS.deep_merge(user_config)
    end

    def self.jekyll_config(options={})
      return @jekyll_config if @jekyll_config

      log_level = Jekyll.logger.log_level
      Jekyll.logger.log_level = Jekyll::Stevenson::WARN
      jekyll_config = Jekyll.configuration(options)
      Jekyll.logger.log_level = log_level

      @jekyll_config = jekyll_config
    end
  end
end
