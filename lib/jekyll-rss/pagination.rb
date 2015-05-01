module Jekyll
  module RSS
    class Pagination
      def self.paginate(site, index_page, posts)
        total_pages = Paginate::Pager.calculate_pages posts.sort_by(&self.sorter), self.per_page(site)
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
    end
  end
end
