require './test_suite'

@failures = []
  
`rm -rf test-site; mkdir test-site`

# Create a blank site
#
test({
  desc: 'Create a blank site',
  cmd: [
    'octopress new . --blank',
    'echo "<div class=\'post\'>{{ page.title }}{{ content }}</div>" > _layouts/post.html',
    'echo "<div class=\'page\'>{{ page.title }}{{ content }}</div>" > _layouts/page.html'
  ],
  expect: 'New jekyll site installed in /Users/imathis/workspace/octodev/cli/test/test-site.'
})

# Add a new post
#
test({
  desc: 'Add a new post',
  cmd: 'octopress new post "Awesome stuff" --date "2014-03-12 05:10 -0500"',
  expect: '/Users/imathis/workspace/octodev/cli/test/test-site/_posts/2014-03-12-awesome-stuff.markdown',
})

# Add another new post with a slug
#
test({
  desc: 'Add another new post with a slug',
  cmd: 'octopress new post "Super Awesome stuff" --slug awesome --date "2014-03-13 15:20 -0500"',
  expect: '/Users/imathis/workspace/octodev/cli/test/test-site/_posts/2014-03-13-awesome.markdown',
})

# Add a draft
#
test({
  desc: 'Add a draft',
  cmd: 'octopress new draft "Stupid idea" --date "2014-03-10 15:20 -0500"',
  expect: '/Users/imathis/workspace/octodev/cli/test/test-site/_drafts/stupid-idea.markdown',
})

# Add a draft with a slug
#
test({
  desc: 'Add a draft with a slug',
  cmd: 'octopress new draft "Some great idea for a post" --slug idea',
  expect: '/Users/imathis/workspace/octodev/cli/test/test-site/_drafts/idea.markdown',
})

# Publish a draft with a date
#
test({
  desc: 'Publish a draft with a date',
  cmd: 'octopress publish _drafts/idea.markdown --date "2014-03-14 20:20 -0500"',
  expect: '/Users/imathis/workspace/octodev/cli/test/test-site/_posts/2014-03-14-idea.markdown',
})

# Add a page
#
test({
  desc: 'Add a page',
  cmd: 'octopress new page awesome-page --title "Awesome Page"',
  expect: '/Users/imathis/workspace/octodev/cli/test/test-site/awesome-page.html',
})

# Add a page with an extension
#
test({
  desc: 'Add a page with an extension',
  cmd: 'octopress new page cool-page.html --title "some cool page"',
  expect: '/Users/imathis/workspace/octodev/cli/test/test-site/cool-page.html',
})

# Add a page with a directory
#
test({
  desc: 'Add a page with a directory',
  cmd: 'octopress new page okay-page/ --title "This page is meh"',
  expect: '/Users/imathis/workspace/octodev/cli/test/test-site/okay-page/index.html',
})

# Build the site
#
test({
  desc: 'Build with Octopress',
  cmd: 'octopress build',
  expect: "Source: /Users/imathis/workspace/octodev/cli/test/test-site
       Destination: /Users/imathis/workspace/octodev/cli/test/test-site/_site
      Generating... done.",
})

compare_directories('test-site', 'expected')

if @failures.empty?
  puts "All passed!".green
else
  print_failures @failures
  abort
end

