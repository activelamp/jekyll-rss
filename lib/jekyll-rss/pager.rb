module Jekyll
  module RSS
    class Pager < ::Jekyll::Paginate::Pager

      attr_reader :path_format

      def initialize(site, page_num, posts, per_page, index_page)
        @index_page = index_page
        super site, page_num, posts, per_page
        @previous_page_path = paginate_path site, @previous_page
        @next_page_path = paginate_path site, @next_page
      end

      def paginated_permalink
        @index_page.data['paginated_permalink']
      end

      def paginate_path(site, num_page)
        return nil if num_page.nil?
        return @index_page.url if num_page <= 1
        placeholders = @index_page.url_placeholders
        placeholders['num'] = num_page.to_s
        url = ::Jekyll::URL.new :placeholders => placeholders, :permalink => paginated_permalink
        url.to_s
      end
    end
  end
end
