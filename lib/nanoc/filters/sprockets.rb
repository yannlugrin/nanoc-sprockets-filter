require 'nanoc'

module Nanoc
  module Filters
    class Sprockets < Nanoc::Filter
      VERSION = '0.1.1'

      type :text

      def self.environment
        nanoc_stderr = $stderr
        $stderr = STDERR

        environment = ::Sprockets::Environment.new(File.expand_path('.')) do |env|
          assets =  ['javascripts', 'stylesheets', 'images', 'fonts']
          paths =   ['content/assets/', 'lib/assets/', 'assets/', 'vendor/assets/' ].map{|p| assets.map{|f| "#{p}#{f}" } }.flatten

          paths.each{ |path| env.append_path path }
        end

        $stderr = nanoc_stderr

        environment
      end

      def environment
        @environment ||= self.class.environment
      end

      def run(content, params = {})
        filename = File.basename(@item[:filename])

        environment.css_compressor = params[:css_compressor]
        environment.js_compressor  = params[:js_compressor]

        if asset = environment[filename]
          asset.to_s
        else
          raise "error locating #{filename} / #{@item[:filename]}"
        end
      end

    end
  end
end

