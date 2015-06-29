
module Jekyll
  module RSS
    class CategoryFeed < RSSFeed
    
      NON_SLUG_REGEX = /[^a-z0-9\-_]/
    
      def initialize(site, path, category)
        @category = category
        @category_slug = category.strip.gsub(' ', '-').gsub(NON_SLUG_REGEX, '')
        super site, path
        self.data['category'] = category.split(' ').map(&:capitalize).join(' ')
        self.data['category_slug'] = @category_slug
      end
      
      def url_placeholders
        placeholders = super
        placeholders[:category] = @category_slug
        placeholders
      end
    end
  end
end