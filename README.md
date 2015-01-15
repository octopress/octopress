# Octopress

Octopress is an obsessively designed toolkit for writing and deploying Jekyll blogs. Pretty sweet, huh?

[![Gem Version](https://badge.fury.io/rb/octopress.png)](http://badge.fury.io/rb/octopress)
[![Build Status](https://travis-ci.org/octopress/octopress.png?branch=master)](https://travis-ci.org/octopress/octopress)

## Installation

Add this line to your application's Gemfile:

    gem 'octopress', '~> 3.0.0.rc'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install octopress --pre

## Octopress Commands

Here are the subcommands for Octopress.

```
init <PATH>         # Adds Octopress scaffolding to your site
new <PATH>          # Like `jekyll new` + `octopress init`
new post <TITLE>    # Add a new post to your site
new page <PATH>     # Add a new page to your site
new draft <TITLE>   # Add a new draft post to your site
publish <POST>      # Publish a draft from _drafts to _posts
unpublish <POST>    # Search for a post and convert it into a draft
isolate [POST]      # Stash all posts but the one you're working on for a faster build
integrate           # Restores all posts, doing the opposite of the isolate command
```

Run `octopress --help` to list sub commands and `octopress <subcommand> --help` to learn more about any subcommand and see its options.

### Init

```sh
$ octopress init <PATH> [options]
```

This will copy Octopress's scaffolding into the specified directory. Use the `--force` option to overwrite existing files. The scaffolding is pretty simple:

```
_templates/
  draft
  post
  page
```

### New Post

This automates the creation of a new post.

```sh
$ octopress new post "My Title"
```

This will create a new file at `_posts/YYYY-MM-DD-my-title.markdown` with the following YAML front-matter already added.

```
layout: post
title: "My Title"
date: YYYY-MM-DDTHH:MM:SS-00:00
```

#### Command options

| Option               | Description                             |
|:---------------------|:----------------------------------------|
| `--template PATH`    | Use a template from <path>              |
| `--date DATE`        | The date for the post. Should be parseable by [Time#parse](http://ruby-doc.org/stdlib-2.1.0/libdoc/time/rdoc/Time.html#method-i-parse) |
| `--slug SLUG`        | Slug for the new post.                  |
| `--dir DIR`          | Create post at _posts/DIR/.             |
| `--force`            | Overwrite existing file.                |

### New Page

Creating a new page is easy, you can use the default file name extension (.html), pass a specific extension, or end with a `/` to create
an index.html document.

```
$ octopress new page some-page           # ./some-page.html
$ octopress new page about.md            # ./about.md
$ octopress new page docs/               # ./docs/index.html
```

If you are working with collections, you might add a page like this:

```
$ octopress new page _legal/terms        # ./_legal/terms.html
```

After the page is created, Octopress will tell you how to configure this new collection.


#### Command options

| Option               | Description                             |
|:---------------------|:----------------------------------------|
| `--template PATH`    | Use a template from <path>              |
| `--title TITLE`      | The title of the new page               |
| `--date DATE`        | The date for the page. Should be parseable by [Time#parse](http://ruby-doc.org/stdlib-2.1.0/libdoc/time/rdoc/Time.html#method-i-parse) |
| `--force`            | Overwrite existing file.                |

Note: The default page template doesn't expect a date. If you want to add dates
to your pages, consider adding `date: {{ date }}` to the default template
`_templates/page`, or create a new template to use for dated pages. Otherwise,
you will have the `--date` option to add a date to a page.

### New Draft

This will create a new post in your `_drafts` directory.

```sh
$ octopress new draft "My Title"
```

| Option             | Description                               |
|:-------------------|:------------------------------------------|
| `--template PATH`  | Use a template from <path>                |
| `--date DATE`      | The date for the draft. Should be parseable by [Time#parse](http://ruby-doc.org/stdlib-2.1.0/libdoc/time/rdoc/Time.html#method-i-parse) (defaults to Time.now) |
| `--slug SLUG`      | The slug for the new post.                |
| `--force`          | Overwrite existing file.                  |

### Publish a draft

Use the `publish` command to publish a draft to the `_posts` folder. This will also rename the file with the proper date format.

```sh
$ octopress publish _drafts/some-cool-post.md
$ octopress publish cool
```
In the first example, a draft is published using the path. The publish command can also search for a post by filename. The second command
would work the same as the first. If other drafts match your search, you will be prompted to select them from a menu. This is often much
faster than typing out the full path.

| Option             | Description                               |
|:-------------------|:------------------------------------------|
| `--date DATE`      | The date for the post. Should be parseable by [Time#parse](http://ruby-doc.org/stdlib-2.1.0/libdoc/time/rdoc/Time.html#method-i-parse) |
| `--slug SLUG`      | Change the slug for the new post.         |
| `--dir DIR`        | Create post at _posts/DIR/.               |
| `--force`          | Overwrite existing file.                  |

When publishing a draft, the new post will use the draft's date. Pass the option `--date now` to the publish command to set the new post date from your system clock. As usual, you can pass any compatible date string as well.

### Unpublish a post

Use the `unpublish` command to move a post to the `_drafts` directory, renaming the file according to the drafts convention.

```sh
$ octopress unpublish _posts/2015-01-10-some-post.md
$ octopress unpublish some post
```

Just like the publish command, you can either pass a path or a search string to match the file name. If more than one match is found, you
will be prompted to select from a menu of posts.

### Templates for Posts and pages

Octopress post and page templates look like this.

```
---
layout: {{ layout }}
title: {{ title }}
---
```

Dates get automatically added to a template for posts, and for pages if a --date option is set.

You can add to the YAML front matter, add content below and even even use liquid tags and filters from your site's plugins. There are
a handful of local variables you can use when working with templates.

| Variable           | Description                               |
|:-------------------|:------------------------------------------|
| `date`             | The date (if set) or Time.now.iso8601     |
| `title`            | The title of the page (if set)            |
| `slug`             | The title in slug form                    |
| `ymd`              | The date string, YYYY/MM/DD format        |
| `year`             | The date's year                           |
| `month`            | The date's month, MM                      |
| `day`              | The date's day, DD                        |

By default Octopress has templates for pages, posts and drafts. You can change them or create new ones for different types of content.
To create linkposts template, add a file at `_templates/linkpost`, such as:

```
---
title: {{ title }}
external-url: {{ url }}
---
```

Then you can use it with a new post like this:

```sh
$ octopress new post "Some title" --template linkpost
$ octopress new post "Some title" -tm _templates/linkpost
```

In the second example, I'm passing the full template file path. This way I can use my shell's tab to auto-complete feature.

When creating templates, file name extensions are unnecessary since the files are just plain text anyway.

## Isolate

The `isolate` command will allow you to stash posts in `_posts/_exile` where they will be ignored by Jekyll during the build process.
Run `octopress integrate` to restore all exiled posts. This can be helpful if you have a very large site and you want to quickly preview a build
for a single post or page.

```sh
$ octopress isolate                                # Move all posts
$ octopress isolate _posts/2014-10-11-kittens.md   # Move post at path
$ octopress isolate kittens                        # Move post matching search
```

In the third example, if multiple posts match the search a prompt will ask you to select a post from a menu.

## Configuration

Octopress reads its configurations from `_config.yml`. Here's what the configuration looks like by default.

```yaml
# Default extension for new posts and pages
post_ext: markdown
page_ext: html

# Default templates for posts and pages
# Found in _templates/
post_layout: post
page_layout: page

# Format titles with titlecase?
titlecase: true

# Change default template file (in _templates/)
post_template: post
page_template: page
draft_template: draft
```

## Contributing

1. Fork it ( https://github.com/octopress/octopress/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
