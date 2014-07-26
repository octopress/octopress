# Octopress Changelog

## Current released version

### 3.0.0 RC14 - 2014-07-26

- Simplified configuration management.
- Now requiring titlecase gem directly.

## Past versions

### 3.0.0 RC13 - 2014-07-24

- Templates are no longer required unless passed as an option.
- The default drafts template doesn't have a date anymore.
- Now using octopress filters for titlecase.

### 3.0.0 RC12 - 2014-05-23

- Change: Default page template no longer includes a date.
- Improved date management when publishing a draft.

### 3.0.0 RC11 - 2014-05-07

- Replaced Hash extensions with Jekyll utility methods.
- Replaced String extension "titlecase" with Octopress utility method.

### 3.0.0 RC10 - 2014-05-07

- Now using SafeYAML.load instead of YAML.safe_load [#38](https://github.com/octopress/octopress/issues/38)

### 3.0.0 RC9 - 2014-05-07

- Support for Jekyll 2.0

### 3.0.0 RC8 - 2014-05-02

- Improved draft date management [#35](https://github.com/octopress/octopress/issues/35)

### 3.0.0 RC7 - 2014-03-24

- Fixed Time.parse with `--date` option on new posts and pages.
- Bumped Jekyll to 1.5.

### 3.0.0 RC6 - 2014-03-22

- Added support for octopress-ink documentation system.
- Added a `update_docs` Rake task to update docs from the readme and changelog.

### 3.0.0 RC5 - 2014-03-21
- Added octopress-docs to blessed gem list.

### 3.0.0 RC4 - 2014-03-18
- Updated mercenary. Fixed issue: #34

### 3.0.0 RC3 - 2014-03-18
- `serve --watch` fixed. Fixed issue: #33

### 3.0.0 RC2 - 2014-03-18
- `new post` command has new `--dir` option to save new posts in _posts/<DIR>/. Fixed issue #31

### 3.0.0 RC1 - 2014-03-17
- Initial release of Octopress CLI

