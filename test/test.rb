require './test_suite'

@failures = []
  
`rm -rf test-site; mkdir test-site`

FileUtils.cd('test-site') do |dir|
  
  # Create a blank site
  #
  test_cmd({
    desc: 'Create a blank site',
    cmd: [
      'octopress new . --blank',
      'echo "<div class=\'post\'>{{ page.title }}{{ content }}</div>" > _layouts/post.html',
      'echo "<div class=\'page\'>{{ page.title }}{{ content }}</div>" > _layouts/page.html',
      'echo "timezone: GMT" > _config.yml'
    ],
    expect: "New jekyll site installed in ."
  })

  # Init Octopress scaffolding
  #
  test_cmd({
    desc: 'Init Octopress scaffolding',
    cmd: 'octopress init .',
    expect: "Octopress scaffold added to ."
  })

  # Add a new post
  #
  test_cmd({
    desc: 'Add a new post',
    cmd: 'octopress new post "Awesome stuff" --date "2014-03-12 05:10 -0000"',
    expect: '_posts/2014-03-12-awesome-stuff.markdown',
  })

  # Add another new post with a slug
  #
  test_cmd({
    desc: 'Add another new post with a slug',
    cmd: 'octopress new post "Super Awesome stuff" --slug awesome --date "2014-03-13 15:20 -0000"',
    expect: '_posts/2014-03-13-awesome.markdown',
  })

  # Add a new post in a subdirectory
  #
  test_cmd({
    desc: 'Add a new post',
    cmd: 'octopress new post "Some stuff" --dir stuff --date "2014-02-11 05:10 -0000"',
    expect: '_posts/stuff/2014-02-11-some-stuff.markdown',
  })

  # Add a draft
  #
  test_cmd({
    desc: 'Add a draft',
    cmd: 'octopress new draft "Stupid idea" --date "2014-03-10 15:20 -0000"',
    expect: '_drafts/stupid-idea.markdown',
  })

  # Add another draft
  #
  test_cmd({
    desc: 'Add another draft',
    cmd: 'octopress new draft "Another idea" --date "2014-02-10 15:20 -0000"',
    expect: '_drafts/another-idea.markdown',
  })

  # Add a draft with a slug
  #
  test_cmd({
    desc: 'Add a draft with a slug',
    cmd: 'octopress new draft "Some great idea for a post" --slug idea',
    expect: '_drafts/idea.markdown',
  })

  # Add yet another draft
  #
  test_cmd({
    desc: 'Add yet another draft',
    cmd: 'octopress new draft "yet another idea" --date "2014-02-13 15:20 -0000"',
    expect: '_drafts/yet-another-idea.markdown',
  })

  # Publish a draft
  #
  test_cmd({
    desc: 'Publish a draft',
    cmd: 'octopress publish _drafts/another-idea.markdown',
    expect: '_posts/2014-02-10-another-idea.markdown',
  })

  # Publish a draft with a date
  #
  test_cmd({
    desc: 'Publish a draft with a date',
    cmd: 'octopress publish _drafts/idea.markdown --date "2014-03-11 20:20 -0000"',
    expect: '_posts/2014-03-11-idea.markdown',
  })

  # Publish a draft in a dir
  #
  test_cmd({
    desc: 'Publish a draft in a dir',
    cmd: 'octopress publish _drafts/yet-another-idea.markdown --dir ideas',
    expect: '_posts/ideas/2014-02-13-yet-another-idea.markdown',
  })

  # Add a page
  #
  test_cmd({
    desc: 'Add a page',
    cmd: 'octopress new page awesome-page --title "Awesome Page"',
    expect: 'awesome-page.html',
  })

  # Add a page with an extension
  #
  test_cmd({
    desc: 'Add a page with an extension',
    cmd: 'octopress new page cool-page.html --title "some cool page"',
    expect: 'cool-page.html',
  })

  # Add a page with a directory
  #
  test_cmd({
    desc: 'Add a page with a directory',
    cmd: 'octopress new page okay-page/ --title "This page is meh"',
    expect: 'okay-page/index.html',
  })

  # Add a page with a date
  #
  test_cmd({
    desc: 'Add a page with a custom template',
    cmd: [
      'echo "---\nlayout: {{ layout }}\ntitle: {{ title }}\nkittens: true\n---" > _templates/other_page',
      'octopress new page custom-template-page.html --title "some date page" --template other_page'
    ],
    expect: 'custom-template-page.html',
  })

  # Add a page with a date
  #
  test_cmd({
    desc: 'Add a page with a date',
    cmd: [
      'echo "---\nlayout: {{ layout }}\ntitle: {{ title }}\ndate: {{ date }}\n---" > _templates/date_page',
      'octopress new page date-page.html --title "some date page" --date "2011-11-11 11:11 -0000" --template date_page'
    ],
    expect: 'date-page.html',
  })
end

# Build the site
#
system "cd test-site; octopress build; cd -"
test_dirs('Compare directories', 'expected', 'test-site')

print_results
