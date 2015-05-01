module Jekyll
  module RSS
    class RSSTemplatesCommand < ::Jekyll::Command
      class << self
        def init_with_program(prog)
          prog.command(:rss_template) do |c|
            c.syntax 'rss_template'
            c.description 'Create the template files you need to format your RSS/Atom feeds.'
            c.option 'blog', '-B', '--blog', 'Generate the blog RSS/Atom feed template'
            c.option 'category', '-C', '--category', 'Generate the category RSS/Atom feed template'

            c.action do |args, options|
              process options
            end
          end
        end

        def process(options)
          config = configuration_from_options(options)
          %w(blog category).each do |template|
            create_template(config, template) if config[template]
          end
        end

        def create_template(config, template)
          from = File.expand_path File.join('..', 'rss_templates', "#{template}.xml"), __FILE__
          dest_dir = File.join File.expand_path(config['source']), '_rss'
          to = File.join dest_dir, "#{template}.xml"

          FileUtils.mkdir(dest_dir) unless Dir.exists? dest_dir

          if File.exists? to
              Jekyll.logger.error "#{to} already exists and I refuse to overwrite it, because of reasons."
          else
              FileUtils.cp from, to
              Jekyll.logger.info "#{to} created."
          end
        end
      end
    end
  end
end
