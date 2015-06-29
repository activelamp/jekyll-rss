module Jekyll
  module RSS
    class Generator < ::Jekyll::Generator
	    def generate(site)
        return nil unless site.config['rss']
        generate_blog_feed site if File.exists? File.join(site.source, '_rss', 'blog.xml')
        generate_category_feeds site if File.exists? File.join(site.source, '_rss', 'category.xml')
        generate_tag_feeds site if File.exists? File.join(site.source, '_rss', 'tag.xml')
      end

      def generate_blog_feed(site)
        path = File.join site.source, '_rss', 'blog.xml'
        feed = RSSFeed.new site, path
        paginate_blog(site, feed) if site.config['rss'].is_a? Hash and site.config['rss']['paginate']
        site.pages << feed
      end

      def generate_category_feeds(site)
        path = File.join site.source, '_rss', 'category.xml'
        site.categories.each do |category, posts|
          feed = CategoryFeed.new site, path, category
          paginate_category(site, feed, category, posts) if site.config['rss'].is_a? Hash and site.config['rss']['paginate']
          site.pages << feed
        end
      end
      
      def generate_tag_feeds(site)
        path = File.join site.source, '_rss', 'tag.xml'
        site.tags.each do |tag, posts|
          feed = TagFeed.new site, path, tag
          paginate_tag(site, feed, tag, posts) if site.config['rss'].is_a? Hash and site.config['rss']['paginate']
          site.pages << feed
        end
      end

      def paginate_blog(site, feed)
        Pagination.paginate site, feed, site.posts do |pager|
          RSSFeed.new feed.site, feed.source
        end
      end

      def paginate_category(site, feed, category_name, category_posts)
        Pagination.paginate site, feed, category_posts do |pager|
          category = CategoryFeed.new feed.site, feed.source, category_name
          category.data['category'] = category_name
          category.data['posts'] = category_posts
          category
        end
      end
      
      def paginate_tag(site, feed, tag_name, tag_posts)
        Pagination.paginate site, feed, tag_posts do |pager|
          tag = TagFeed.new feed.site, feed.source, tag_name
          tag.data['tag'] = tag_name
          tag.data['posts'] = tag_posts
          tag
        end
      end
	  end
  end
end
