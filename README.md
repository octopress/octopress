# Octopress

Octopress is an obsessively designed toolkit for writing and deploying Jekyll
blogs. Pretty sweet, huh?

## Installation

Add this line to your application's Gemfile:

    gem 'octopress'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install octopress

## Usage

### Start a new site

To create a site scaffold in a new directory named my_blog:

```bash
$ octopress new my_blog
```

Essentially this works just like `jekyll new`, but it also adds some Octopress scaffolding as well.

### Generating a new post

This automates the creation of a new Jekyll blog post.

```bash
$ octopress new post "My Title"
```

This will create a new file at `_posts/YYYY-MM-DD-my-title.markdown` with the following YAML front-matter already added.

```
layout: post
title: "My Title"
date: YYYY-MM-DDTHH:MM:SS-00:00
```

"Ok, great? What else can I do?" Great question! Check out these other options:

| Option         | Type     | Description |
|:---------------|:---------|:------------|
| `--template`   | `String` | Use a post template _templates/<file> |
| `--date`       | `String` | The date for the post. Should be parseable by [Time#parse](http://ruby-doc.org/stdlib-2.1.0/libdoc/time/rdoc/Time.html#method-i-parse) (defaults to Time.now) |
| `--slug`       | `String` | Slug for the new post. |
| `--force`      | `Boolean`| Overwrite exsiting file.   |

### Generating a new page

```bash
$ octopress new page path/to/index.markdown
```

| Option         | Type     | Description |
|:---------------|:---------|:------------|
| `--template`   | `String` | Use a page template _templates/<file> |
| `--title`      | `String` | The title of the new page |
| `--date`       | `String` | The date for the page. Should be parseable by [Time#parse](http://ruby-doc.org/stdlib-2.1.0/libdoc/time/rdoc/Time.html#method-i-parse) |
| `--force`      | `Boolean`| Overwrite exsiting file.   |

### Generating a new draft post

```bash
$ octopress new draft "My Title"
```

This will create a new post in your `_drafts` directory.

| Option         | Type     | Description |
|:---------------|:---------|:------------|
| `--template`   | `String` | Use a post template _templates/<file> |
| `--date`       | `String` | The date for the post. Should be parseable by [Time#parse](http://ruby-doc.org/stdlib-2.1.0/libdoc/time/rdoc/Time.html#method-i-parse) (defaults to Time.now) |
| `--slug`       | `String` | The slug for the new post. |
| `--force`      | `Boolean`| Overwrite exsiting file.   |

### Publish a draft post

```bash
$ octopress publish _drafts/filename.md
```

This will convert your draft post to a normal post in the `_posts` directory.

| Option         | Type     | Description |
|:---------------|:---------|:------------|
| `--date`       | `String` | Change the date for the post. Should be parseable by [Time#parse](http://ruby-doc.org/stdlib-2.1.0/libdoc/time/rdoc/Time.html#method-i-parse) (defaults to Time.now) |
| `--slug`       | `String` | Change the slug for the new post. |
| `--force`      | `Boolean`| Overwrite exsiting file.   |
```

When publishing a draft, you probably want to update the date for your post. Pass the option `--date now` to set the current day and time from your system clock.

### Templates for Posts, Pages and Drafts

To make creating new pages and posts easy, Octopress allows you to create templates for pages and posts. The default post template looks like this.

```html
---
layout: {{ layout }}
title: {{ title }}
date: {{ date }}
---

```

The YAML variables will be replaced with the correct content when you create a page or post. To modify this template create a `_templates/post` file and change it as you wish. You can add additional YAML front-matter or content, and you can even create multiple templates. Choose a custom template when creating a new post or page like this.

```sh
octopress new post --template _templates/linkpost
```

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

This file is created with the site scaffolding when you run `octopress new` but if you already have a site you can add the scaffolding by running `octopress new scaffold .` from within your project.

### Deployment

You can deploy your Octopress or Jeklly blog via git, rsync or Amazon S3. The deployment system ships with the [octopress-deploy][] gem which extends the Octopress CLI with the `deploy` command.

[octopress-deploy]: https://github.com/octopress/deploy

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
