# Octopress

Octopress is an obsessively designed toolkit for writing and deploying Jekyll blogs. Pretty sweet, huh?

<!--[![Gem Version](https://badge.fury.io/rb/octopress.png)](http://badge.fury.io/rb/octopress)-->
[![Build Status](https://travis-ci.org/octopress/octopress.png?branch=master)](https://travis-ci.org/octopress/octopress)

## Installation

Add this line to your application's Gemfile:

    gem 'octopress', '~> 3.0.0.rc'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install octopress --pre

## Basic Usage

Here are the commands for Octopress.

| Option                          | Description                                   |
|:--------------------------------|:----------------------------------------------|
| `octopress init <PATH>`         |  Adds Octopress scaffolding to your site      |
| `octopress new <PATH>`          |  Like `jekyll new` + `octopress init`         |
| `octopress new post <TITLE>`    |  Add a new post to your site                  |
| `octopress new page <PATH>`     |  Add a new page to your site                  |
| `octopress new draft <TITLE>`   |  Add a new draft post to your site            |
| `octopress publish <PATH>`      |  Publish a draft from _drafts to _posts       |
| `octopress unpublish <SEARCH>`  |  Convert a post into a draft                  |
| `octopress isolate [search]`    |  Isolate one or more posts for a faster build |
| `octopress integrate`           |  Restores all posts, reverting isolation.     |

Run `octopress [command] --help` to learn more about any command and see its options.

### Deployment

You can deploy your Octopress or Jekyll blog via git, rsync or Amazon S3. The deployment system ships with the [octopress-deploy][] gem which extends the Octopress CLI with the `deploy` command.

[octopress-deploy]: https://github.com/octopress/deploy

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
