# Jekyll::RSS

Generate some RSS/Atom feeds for your Jekyll blog.

## Installation

Add the following to your `Gemfile`:

```ruby
group :jekyll_plugins do
  gem 'jekyll-rss'
end
```

## Usage

Execute the `rss_templates` Jekyll subcommand to generate the necessary templates onto your source directory:

`jekyll rss_templates --blog --category`

This will create an `_rss` directory on your source directory with two files -- `blog.xml` and `category.xml`, which is read by the generator to generate the all-encompassing feed and the categorized feeds respectively.

You can omit either `--blog` or `--category` depending on your needs.

Next step is to enable the plugin by adding this to your `_config.yml`:

```yaml
rss: true
```

or 

```yaml
rss:
   paginate: 5 #Number of posts per page.
```

## Permalinks

The permalink for the feeds can be configured from within the front-matter of the template files. 

#### Default config
`_rss/blog.xml`:
```yaml
permalink: /rss/feed.xml
paginated_permalink: /rss/:num/feed.xml
```

#### Result:

`/rss/feed.xml`, `/rss/1/feed.xml`, `/rss/2/feed.xml`, etc.

#### Default config
`rss/category.xml`
```
permalink: /rss/:category.xml
paginated_permalink: /rss/:num/:category.xml
```
#### Result:

`/rss/foobar.xml`, `/rss/1/foobar.xml`, `/rss/2/foobar.xml`, etc.

Note that the permalink **must** end with `.xml`, so that the proper content type is detected even when using the least capable of web-servers i.e. a public hosted directory like an Amazon S3 bucket.
