# Nanoc::Sprockets::Filter

A nanoc filter to use [Sprockets][sprockets], a Ruby library for compiling and serving web assets.

## Installation

Add this line to your application's Gemfile:

    gem 'nanoc-sprockets-filter'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nanoc-sprockets-filter

## Usage

We recommend installing the [sprockets-sass][sprockets-sass] and [sprockets-helpers][sprockets-helpers]
gems for better integration. Also, use the [uglifier][uglifier] gem to minify
javascripts. All these dependencies are optional and you can use any other
compressor supported by Sprockets.

Require dependencies and configure Sprockets helpers to generate assets
with digest.

```ruby
require 'sass'
require 'uglifier'
require 'sprockets-sass'
require 'nanoc-sprockets-filter'

Nanoc::Helpers::Sprockets.configure do |config|
  config.environment = Nanoc::Filters::Sprockets.environment
  config.prefix      = '/assets'
  config.digest      = true
end
```

Add compile rule for stylesheets and javascripts, `css_compressor`and
`js_compressor` is optionnal and value can be replaced by any compressor
supported by Sprockets.

```ruby
compile %r{/assets/(stylesheets|javascripts)/.+/} do
  filter :sprockets, {
    :css_compressor => :scss,
    :js_compressor  => :uglifier
  }
end
```

You can use [nanoc-gzip-filter][nanoc-gzip-filter] to create a
gzipped version of stylesheets and javascripts files.

```ruby
compile %r{/assets/(stylesheets|javascripts)/.+/}, :rep => :gzip do
  filter :sprockets, {
    :css_compressor => :scss,
    :js_compressor  => :uglifier
  }
  filter :gzip
end
```

Add route rule for all assets and use [sprockets-helpers][sprockets-helpers]
to generate file path.

```ruby
route '/assets/*/' do
  Nanoc::Helpers::Sprockets.asset_path(item)
end
```

```ruby
route '/assets/*/', :rep => :gzip do
  Nanoc::Helpers::Sprockets.asset_path(item) + '.gz'
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

[sprockets]: https://github.com/sstephenson/sprockets "Rack-based asset packaging"
[sprockets-sass]: https://github.com/petebrowne/sprockets-sass "Better Sass integration with Sprockets 2.x"
[sprockets-helpers]: https://github.com/petebrowne/sprockets-helpers "Asset path helpers for Sprockets 2.x applications"
[uglifier]: https://github.com/lautis/uglifier "Ruby wrapper for UglifyJS JavaScript compressor"
[nanoc-gzip-filter]: https://github.com/yannlugrin/nanoc-sprockets-filter "A nanoc filter to gzip content"

