
module Jekyll
  module RSS
    class TagFeed < RSSFeed
    
      NON_SLUG_REGEX = /[^a-z0-9\-_]/
    
      def initialize(site, path, tag)
        @tag = tag
        @tag_slug = tag.strip.gsub(' ', '-').gsub(NON_SLUG_REGEX, '')
        super site, path
        self.data['tag'] = tag.split(' ').map(&:capitalize).join(' ')
        self.data['tag_slug'] = @tag_slug
      end
      
      def url_placeholders
        placeholders = super
        placeholders[:tag] = @tag_slug
        placeholders
      end
    end
  end
end