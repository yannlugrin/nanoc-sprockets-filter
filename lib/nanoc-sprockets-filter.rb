require 'nanoc'
require 'sprockets'

module Nanoc
  module Filters
    autoload 'Sprockets', 'nanoc/filters/sprockets'

    Nanoc::Filter.register '::Nanoc::Filters::Sprockets', :sprockets
  end

  module Helpers
    autoload 'Sprockets', 'nanoc/helpers/sprockets'
  end
end

