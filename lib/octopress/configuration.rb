module Octopress
  module Configuration

    DEFAULTS = {
      'new_post_extension' => 'markdown',
      'new_page_extension' => 'html',
      'new_post_layout' => 'post',
      'new_page_layout' => 'page',
      'titlecase' => true
    }

    def self.config(options={})
      return @config if @config

      file = '_octopress.yml'
      config = {}
      if File.exist? file
        config = YAML.safe_load(File.open(file))
      end
      config['jekyll'] = jekyll_config(options)
      @config = DEFAULTS.deep_merge(config)
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
