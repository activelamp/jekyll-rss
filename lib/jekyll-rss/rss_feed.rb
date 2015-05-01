module Jekyll
  module RSS
    class RSSFeed < Page

      attr_reader :source

      def initialize(site, path)
        @site = site
        @base = site.source
        @source = path
        @dir = File.dirname(path)
        basename = File.basename(path)
        process basename
        read_yaml File.dirname(path), basename
      end
    end
  end
end
