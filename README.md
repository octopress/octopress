# Octopress

Octopress is an obsessively designed toolkit for writing and deploying Jekyll blogs. Pretty sweet, huh?

<!--[![Gem Version](https://badge.fury.io/rb/octopress.png)](http://badge.fury.io/rb/octopress)-->
[![Build Status](https://travis-ci.org/octopress/octopress.png?branch=master)](https://travis-ci.org/octopress/octopress)

## Installation

Add this line to your application's Gemfile:

    gem 'octopress', '~> 3.0.0.rc.12'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install octopress --pre

## Basic Usage

Here are the commands for Octopress.

| Option                          | Description                               |
|:--------------------------------|:------------------------------------------|
| `octopress init <PATH>`         |  Adds Octopress scaffolding to your site  |
| `octopress new post <TITLE>`    |  Add a new post to your site              |
| `octopress new page <PATH>`     |  Add a new page to your site              |
| `octopress new draft <TITLE>`   |  Add a new draft post to your site        |
| `octopress publish <PATH>`      |  Publish a draft from _drafts to _posts   |
| `octopress new <PATH>`          |  works just like `jekyll new`             |
| `octopress build`               |  works just like `jekyll build`           |
| `octopress serve`               |  works just like `jekyll serve`           |
| `octopress doctor`              |  works just like `jekyll doctor`          |

Run `octopress [command] --help` to learn more about any command and see its options.

### Deployment

You can deploy your Octopress or Jekyll blog via git, rsync or Amazon S3. The deployment system ships with the [octopress-deploy][] gem which extends the Octopress CLI with the `deploy` command.

[octopress-deploy]: https://github.com/octopress/deploy

## Configuration

Octopress reads its configurations from `_octopress.yml`. Here's what the configuration looks like by default.

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
```

## Commands

### Init


```sh
$ octopress init <PATH> [options]
```

This will copy Octopress's scaffolding into the specified directory. Use the `--force` option to overwrite existing files. The scaffolding is pretty simple:

```
_octopress.yml
_templates/
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

"OK, great. What else can I do?" Great question! Check out these other options:

| Option               | Description                             |
|:---------------------|:----------------------------------------|
| `--template PATH`    | Use a template from <path>              |
| `--date DATE`        | The date for the post. Should be parseable by [Time#parse](http://ruby-doc.org/stdlib-2.1.0/libdoc/time/rdoc/Time.html#method-i-parse) |
| `--slug SLUG`        | Slug for the new post.                  |
| `--dir DIR`          | Create post at _posts/DIR/.             |
| `--force`            | Overwrite existing file.                |

### New Page

```
$ octopress new page some-page           # ./some-page.html
$ octopress new page docs/               # ./docs/index.html
$ octopress new page about.html          # ./about.html
```

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

```sh
$ octopress new draft "My Title"
```

This will create a new post in your `_drafts` directory.

| Option             | Description                               |
|:-------------------|:------------------------------------------|
| `--template PATH`    | Use a template from <path>              |
| `--date DATE`      | The date for the draft. Should be parseable by [Time#parse](http://ruby-doc.org/stdlib-2.1.0/libdoc/time/rdoc/Time.html#method-i-parse) (defaults to Time.now) |
| `--slug SLUG`      | The slug for the new post.                |
| `--force`          | Overwrite exsiting file.                  |

### Publish draft

```sh
$ octopress publish _drafts/some-post.md
```

This will move your draft to the `_posts` directory and rename the file with the proper date.

| Option             | Description                               |
|:-------------------|:------------------------------------------|
| `--date DATE`      | The date for the post. Should be parseable by [Time#parse](http://ruby-doc.org/stdlib-2.1.0/libdoc/time/rdoc/Time.html#method-i-parse) |
| `--slug SLUG`      | Change the slug for the new post.         |
| `--dir DIR`        | Create post at _posts/DIR/.               |
| `--force`          | Overwrite existing file.                  |

When publishing a draft, the new post will use the draft's date. Pass the option `--date now` to the publish command to set the new post date from your system clock. As usual, you can pass any compatible date string as well.

### Templates for Posts and pages

Octopress post and page templates look like this.

```
---
layout: {{ layout }}
title: {{ title }}
---

```

The YAML variables will be replaced with the correct content when you create a page or post. To modify this template create a `_templates/post` file and change it as you wish. You can add additional YAML front-matter or content, and you can even create multiple templates. Choose a custom template when creating a new post or page like this.

```sh
$ octopress new post --template _templates/linkpost
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
