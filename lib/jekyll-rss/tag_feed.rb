
module Jekyll
  module RSS
    class TagFeed < RSSFeed
    
      NON_SLUG_REGEX = /[^a-z0-9\-_]/
    
      def initialize(site, path, tag)
        @tag = tag
        @tag_slug = tag.strip.gsub(' ', '-').gsub(NON_SLUG_REGEX, '')
        super site, path
      end
      
      def url_placeholders
        placeholders = super
        placeholders[:tag] = @tag_slug
        placeholders
      end
    end
  end
end