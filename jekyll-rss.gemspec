require File.expand_path('../lib/jekyll-rss/version', __FILE__)

Gem::Specification.new do |s|
  s.name = 'jekyll-rss'
  s.version = Jekyll::RSS::VERSION
  s.date = '2015-05-01'
  s.summary = 'RSS/Atom feeds for Jekyll'
  s.description = 'Generate RSS/Atom feeds for your Jekyll site. You can have a feed for all blog posts and also feeds for each category. Pagination supported.'
  s.authors = ['Bez Hermoso']
  s.email = 'bezalelhermoso@gmail.com'
  s.files = Dir["lib/**/*"]
  s.homepage = 'http://rubygems.org/gems/jekyll-rss'
  s.license = 'MIT'
end
