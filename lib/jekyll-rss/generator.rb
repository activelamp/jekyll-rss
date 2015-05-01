module Jekyll
  module RSS
    class Generator < ::Jekyll::Generator
	  def generate(site)
        return nil unless site.config['rss']
        generate_blog_feed site if File.exists? File.join(site.source, '_rss', 'blog.xml')
        generate_category_feeds site if File.exists? File.join(site.source, '_rss', 'category.xml')
      end

      def generate_blog_feed(site)
        path = File.join site.source, '_rss', 'blog.xml'
        feed = RSSFeed.new site, path
        per_page = feed.data['per_page'] || self.class.per_page(site)
        paginate_blog(site, feed, per_page) if site.config['rss'].is_a? Hash and site.config['rss']['paginate']
        site.pages << feed
      end

      def generate_category_feeds(site)
        path = File.join site.source, '_rss', 'category.xml'
        site.categories.each do |category, posts|
          feed = CategoryFeed.new site, path, category
          per_page = feed.data['per_page'] || self.class.per_page(site)
          paginate_category(site, feed, category, posts, per_page) if site.config['rss'].is_a? Hash and site.config['rss']['paginate']
          site.pages << feed
        end
      end
    
      def self.paginate(site, index_page, posts, per_page)
        total_pages = Paginate::Pager.calculate_pages posts, per_page
        (1..total_pages).each do |page_num|
          pager = Pager.new site, page_num, posts, total_pages, index_page
          if page_num > 1
            subpage = yield pager
            subpage.data['permalink'] = index_page.data['paginated_permalink'].gsub(':num', page_num.to_s)
            subpage.pager = pager
            site.pages << subpage
          else
            index_page.pager = pager
          end
        end
      end
    
      def self.per_page(site)
        paginate = site.config['rss']['paginate']
        raise(ArgumentError, "rss.paginate is set to `#{paginate}`. Must be a number, and should be greater than 0") unless paginate.is_a? Integer and paginate > 0
        return paginate
      end
    
      def self.sorter
        lambda { |post| -post.date.to_f }
      end

      def paginate_blog(site, feed, per_page)
        self.class.paginate site, feed, site.posts.sort_by(&self.class.sorter), per_page do |pager|
          RSSFeed.new feed.site, feed.file_path
        end
      end
    
      def paginate_category(site, feed, category_name, category_posts, per_page)
        self.class.paginate site, feed, category_posts.sort_by(&self.class.sorter), per_page do |pager|
          category = CategoryFeed.new feed.site, feed.file_path, category_name
          category.data['category'] = category_name
          category.data['posts'] = category_posts
          category
        end
      end
	  end
  end
end