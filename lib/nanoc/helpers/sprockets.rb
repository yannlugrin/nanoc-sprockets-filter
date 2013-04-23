begin
  require 'sprockets-helpers'
rescue LoadError => e
  $stderr.puts e
  $stderr.puts "If you are using a Gemfile, make sure that the Gemfile contains sprockets-helpers ('gem \"sprockets-helpers\"')."
  exit 1
end

module Nanoc
  module Helpers
    module Sprockets

      def self.configure(*args, &block)
        ::Sprockets::Helpers.configure(*args, &block)
      end

      module ModuleMethods

        def asset_path(item_or_filename, options = {})
          if item_or_filename.is_a?(::Nanoc::Item)
            filename = item_or_filename[:filename]
          else
            filename = item_or_filename
          end
          filename = File.basename(filename).gsub(/^(\w+\.\w+).*/, '\1')

          if rep_name = options.delete(:rep)
            rep_prefix = rep_name.to_s + '_'
          else
            rep_prefix = ''
          end

          super(filename, options).gsub(/([^\/]+)$/, "#{rep_prefix}\\1")
        end

      end

      def self.included(base)
        base.send :include, ::Sprockets::Helpers
        base.send :include, ModuleMethods
      end
    end
  end
end
