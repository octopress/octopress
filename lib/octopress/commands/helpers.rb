module Octopress
  module CommandHelpers
    def self.add_build_options(c)
      c.option 'config',      '--config <CONFIG_FILE>[,CONFIG_FILE2,...]', Array, 'Custom Jekyll configuration file'
      c.option 'octopress-config', '--octopress-config <CONFIG_FILE>', 'Custom Octopress configuration file'
      c.option 'future',      '--future',    'Publishes posts with a future date'
      c.option 'limit_posts', '--limit_posts MAX_POSTS', Integer, 'Limits the number of posts to parse and publish'
      c.option 'watch',       '--watch',     'Watch for changes and rebuild'
      c.option 'list',        '--lsi',       'Use LSI for improved related posts'
      c.option 'drafts','-D', '--drafts',    'Render posts in the _drafts folder'
      c.option 'verbose',     '--verbose',   'Print verbose output.'
    end

    def self.normalize_options(options)
      if drafts_state = options.delete('drafts')
        options['show_drafts'] = drafts_state
      end
      options
    end

    def self.add_page_options(c)
      c.option 'template', '--template PATH', "New #{c.name.to_s} from a template."
      c.option 'date', '--date DATE', "Use 'now' or a String that is parseable by Time#parse."
      c.option 'force', '--force', 'Overwrite file if it already exists'
    end

    def self.add_common_options(c)
      c.option 'config', '--config <CONFIG_FILE>[,CONFIG_FILE2,...]', Array, 'Custom Jekyll configuration file'
      c.option 'octopress-config', '--octopress-config <CONFIG_FILE>', 'Custom Octopress configuration file'
    end
  end
end
