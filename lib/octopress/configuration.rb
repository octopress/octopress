module Octopress
  module Configuration

    DEFAULTS = {
      'post_ext' => 'markdown',
      'page_ext' => 'html',
      'post_layout' => 'post',
      'page_layout' => 'page',
      'titlecase' => true
    }

    # Read _octopress.yml and merge with defaults
    #
    def self.config(options={})

      # Cache loading the config file
      unless @user_config
        file = options['octopress-config'] || '_octopress.yml'

        if File.exist? file
          config = SafeYAML.load_file(file) || {}
        else
          config = {}
        end
        
        # Allow cli extensioins to override default user configuration
        if options['override']
          config = Jekyll::Utils.deep_merge_hashes(config, options['override'])
        end

        # Merge Octopress defaults
        @user_config = Jekyll::Utils.deep_merge_hashes(DEFAULTS, config)
      end

      @user_config
    end

    # Read Jekyll's _config.yml merged with Jekyll's defaults
    #
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
