require './test_suite'

@failures = []
  
`rm -rf test-site; mkdir test-site`

FileUtils.cd('test-site') do |dir|
  
  # Create a blank site
  #
  test({
    desc: 'Create a blank site',
    cmd: [
      'octopress new . --blank',
      'echo "<div class=\'post\'>{{ page.title }}{{ content }}</div>" > _layouts/post.html',
      'echo "<div class=\'page\'>{{ page.title }}{{ content }}</div>" > _layouts/page.html'
    ],
    expect: 'New jekyll site installed in .'
  })

  # Add a new post
  #
  test({
    desc: 'Add a new post',
    cmd: 'octopress new post "Awesome stuff" --date "2014-03-12 05:10 -0000"',
    expect: '_posts/2014-03-12-awesome-stuff.markdown',
  })

  # Add another new post with a slug
  #
  test({
    desc: 'Add another new post with a slug',
    cmd: 'octopress new post "Super Awesome stuff" --slug awesome --date "2014-03-13 15:20 -0000"',
    expect: '_posts/2014-03-13-awesome.markdown',
  })

  # Add a draft
  #
  test({
    desc: 'Add a draft',
    cmd: 'octopress new draft "Stupid idea" --date "2014-03-10 15:20 -0000"',
    expect: '_drafts/stupid-idea.markdown',
  })

  # Add a draft with a slug
  #
  test({
    desc: 'Add a draft with a slug',
    cmd: 'octopress new draft "Some great idea for a post" --slug idea',
    expect: '_drafts/idea.markdown',
  })

  # Publish a draft with a date
  #
  test({
    desc: 'Publish a draft with a date',
    cmd: 'octopress publish _drafts/idea.markdown --date "2014-03-11 20:20 -0000"',
    expect: '_posts/2014-03-11-idea.markdown',
  })

  # Add a page
  #
  test({
    desc: 'Add a page',
    cmd: 'octopress new page awesome-page --title "Awesome Page"',
    expect: 'awesome-page.html',
  })

  # Add a page with an extension
  #
  test({
    desc: 'Add a page with an extension',
    cmd: 'octopress new page cool-page.html --title "some cool page"',
    expect: 'cool-page.html',
  })

  # Add a page with a directory
  #
  test({
    desc: 'Add a page with a directory',
    cmd: 'octopress new page okay-page/ --title "This page is meh"',
    expect: 'okay-page/index.html',
  })


end

# Build the site
#
system "cd test-site; octopress build; cd -"
compare_directories('test-site', 'expected')

if @failures.empty?
  puts "All passed!".green
else
  print_failures @failures
  abort
end

