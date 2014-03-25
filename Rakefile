require "bundler/gem_tasks"
require "octopress-ink"

desc "Copy Readme and Changelog into docs"
task :update_docs do
  Octopress::Ink.copy_doc 'README.md', 'assets/docs/index.markdown'
  Octopress::Ink.copy_doc 'CHANGELOG.md', 'assets/docs/changelog.markdown', '/changelog/'
end
