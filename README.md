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

### Generating a new site

To create a new scaffold of directories and files in a new directory named my_blog:

```bash
$ octopress new my_blog
```

### Generating a new post

```bash
$ octopress new post "My Title"
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

### Other Commands

Octopress also has the following commands, bundled as separate gems:

| Command  | Gem                  | Description |
|:---------|:---------------------|:------------|
| `deploy` | [octopress-deploy][] | Deployment for Octopress and Jekyll blogs. |

[octopress-deploy]: https://github.com/octopress/deploy

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
