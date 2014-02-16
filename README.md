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

### Generating a new Post

```bash
$ octopress new post --title "My Title"
```

"Ok, great? What else can I do?" Great question! Check out these other options:

| Option       | Type     | Description |
|:-------------|:---------|:------------|
| `title`      | `String` | The title of the new post |
| `date`       | `String` | The date for the post. Should be parseable by [Time#parse](http://ruby-doc.org/stdlib-2.1.0/libdoc/time/rdoc/Time.html#method-i-parse) |
| `slug`       | `String` | The slug for the new post. |
| `categories` | `Array`  | A comma-separated list of categories to which this post belongs |
| `tags`       | `Array`  | A comma-separated list of tags for this post |

### Generating a new Page

```bash
$ octopress new page --path about/index.markdown
```

| Option       | Type     | Description |
|:-------------|:---------|:------------|
| `title`      | `String` | The title of the new page |
| `date`       | `String` | The date for the page. Should be parseable by [Time#parse](http://ruby-doc.org/stdlib-2.1.0/libdoc/time/rdoc/Time.html#method-i-parse) |
| `path`       | `String` | The path at which the new page should be generated. |

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
