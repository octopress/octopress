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
        user_config = SafeYAML.load_file(file) || {}
      end

      user_config = Jekyll::Utils.deep_merge_hashes(user_config, options['override'] || {})
      user_config = Jekyll::Utils.deep_merge_hashes(options['defaults'] || {}, user_config)

      @config = Jekyll::Utils.deep_merge_hashes(DEFAULTS, user_config)
    end

    def self.jekyll_config(options={})
      return @jekyll_config if @jekyll_config

      configs = Jekyll::Configuration::DEFAULTS

      (options['config'] || ['_config.yml']).each do |file|
        if File.exist? file
          configs = Jekyll::Utils.deep_merge_hashes(configs, SafeYAML.load_file(file) || {})
        end
      end

      @jekyll_config = configs
    end
  end
end
