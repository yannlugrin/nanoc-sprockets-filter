# -*- encoding: utf-8 -*-
require File.expand_path('../lib/nanoc/filters/sprockets', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['Yann Lugrin']
  gem.email         = ['yann.lugrin@sans-savoir.net']
  gem.description   = %q{A nanoc filter to use Sprockets, a Ruby library for compiling and serving web assets.}
  gem.summary       = %q{A nanoc filter to use Sprockets, a Ruby library for compiling and serving web assets.}
  gem.homepage      = 'https://github.com/yannlugrin/nanoc-sprockets-filter'

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = 'nanoc-sprockets-filter'
  gem.require_paths = ['lib']
  gem.version       = Nanoc::Filters::Sprockets::VERSION

  gem.add_dependency 'nanoc',     '>= 3.4.0'
  gem.add_dependency 'sprockets', '>= 2.8.0'

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'sprockets-helpers'
end
