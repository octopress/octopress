---
title: Using Octopress
---

{% include install.html %}

## Octopress Commands

Here are the subcommands for Octopress.

- `init <PATH>`          Adds Octopress scaffolding to your site.
- `new <PATH>`           Like `jekyll new` + `octopress init`
- `new post <TITLE>`     Add a new post to your site
- `new page <PATH>`      Add a new page to your site
- `new draft <TITLE>`    Add a new draft post to your site
- `publish <PATH>`       Publish a draft from _drafts to _posts
- `isolate [search]`     Isolate one or more posts for a faster build
- `integrate`            Restores all posts, reverting isolation.

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

```sh
$ octopress new draft "My Title"
```

This will create a new post in your `_drafts` directory.

| Option             | Description                               |
|:-------------------|:------------------------------------------|
| `--template PATH`  | Use a template from <path>                |
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
To create linkposts template, add a file at `_templates/linkpost` and use it with a new post like this:

```sh
$ octopress new post --template _templates/linkpost
```

File name extensions are unnecessary since they're just plain text anyway.

## Isolate

If your site is taking a while to build, but you want to preview a post quickly, you can isolate that post temporarily with the isolate command. Here's the syntax:

```
octopress isolate [SEARCH] [options]
```

This will copy all other posts into `_posts/_exile` where they will be ignored by Jekyll during the build process. Here are some examples:

- `octopress isolate` isolates the most recently dated post.
- `octopress isolate cats` isolates all posts with the word 'cats' in the filename.
- `octopress isolate --path _posts/2014-10-11-kittens.md` isolates the post at the given path.

To reintegrate all exiled posts, run `octopress integrate` which will restore all posts from `_posts/_exile` to `_posts`.

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
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
