module Octopress
  module CommandHelpers
    def self.add_page_options(c)
      c.option 'template', '--template PATH', "New #{c.name.to_s} from a template."
      c.option 'date',     '--date DATE', "Use 'now' or a String that is parseable by Time#parse."
      c.option 'force',    '--force', 'Overwrite file if it already exists'
    end

    def self.add_common_options(c)
      c.option 'config',           '--config <CONFIG_FILE>[,CONFIG_FILE2,...]', Array, 'Custom Jekyll configuration file'
    end
  end
end
