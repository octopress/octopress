module Octopress
  module Configuration

    DEFAULTS = {
      'post_ext' => 'markdown',
      'page_ext' => 'html',
      'post_layout' => 'post',
      'page_layout' => 'page',
      'titlecase' => true
    }

    def self.config(options={})
      return @config if @config

      file = options['octopress-config'] || '_octopress.yml'
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

      configs = Jekyll::Configuration::DEFAULTS

      (options['config'] || ['_config.yml']).each do |file|
        if File.exist? file
          configs = configs.deep_merge YAML.safe_load(File.open(file)) 
        end
      end

      @jekyll_config = configs
    end
  end
end
