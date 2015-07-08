# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'xcody/version'

Gem::Specification.new do |spec|
  spec.name          = "xcody"
  spec.version       = Xcody::VERSION
  spec.authors       = ["Kazuaki MATSUO"]
  spec.email         = ["fly.49.89.over@gmail.com"]
  spec.summary       = %q{Simple Xcode command wrapper}
  spec.description   = %q{Simple Xcode command wrapper}
  spec.homepage      = "https://github.com/KazuCocoa/xcody"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
end
