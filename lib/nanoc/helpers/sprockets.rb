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

      def self.method_missing(method, *args)
        if ::Sprockets::Helpers.respond_to?(method)
          if block_given?
            ::Sprockets::Helpers.send(method, *args) do |*block_args|
              yield *block_args
            end
          else
            ::Sprockets::Helpers.send(method, *args)
          end
        else
          super
        end
      end

      def method_missing(method, *args)
        if ::Sprockets::Helpers.respond_to?(method)
          if block_given?
            ::Sprockets::Helpers.send(method, *args) do |*block_args|
              yield *block_args
            end
          else
            ::Sprockets::Helpers.send(method, *args)
          end
        else
          super
        end
      end

    end
  end
end

