module Octopress
  module Helpers
    def self.add_build_options(c)
      c.option 'config',      '--config CONFIG_FILE[,CONFIG_FILE2,...]', Array, 'Custom configuration file'
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
  end
end
