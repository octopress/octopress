module Octopress
  module Docs
    class DocsSiteHook < Octopress::Hooks::Site
      def pre_render(site)
        if Octopress::Docs.enabled?
          Octopress.site = site
          site.pages.concat Octopress::Docs.pages
        end
      end

      def merge_payload(payload, site)
        if Octopress::Docs.enabled?
          Octopress::Docs.pages_info
        end
      end
    end
  end
end

