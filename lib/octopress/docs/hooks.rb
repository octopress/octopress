module Octopress
  module Docs
    Jekyll::Hooks.register :site, :pre_render do |site, payload|
      if Octopress::Docs.enabled?
        Octopress::Docs.pages_info.each do |key, val|
          Octopress.site = site
          site.pages.concat Octopress::Docs.pages
          payload[key] = val
        end
      end
    end
  end
end

