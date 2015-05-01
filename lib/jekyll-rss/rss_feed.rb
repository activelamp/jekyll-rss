module Jekyll
  module RSS
    class RSSFeed < Page
    
      attr_reader :file_path
      
      def initialize(site, path)
        @site = site
        @base = site.source
        @file_path = path
        @dir = File.dirname(path)
        basename = File.basename(path)
        process basename
        read_yaml File.dirname(path), basename
      end
    end
  end
end