# Xcody

Simple wrapper for Xcode commands with Ruby.
Please use other library if you would like to use rich features.
e.g. https://github.com/CocoaPods/Xcodeproj

[![Gem Version](https://badge.fury.io/rb/xcody.svg)](https://badge.fury.io/rb/xcody)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'xcody'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install xcody

## Usage

```
# Build "your_project.xcodeproj"
log_file = "file/to/path.log"

Xcody.new.xcode_build.project("your_project.xcodeproj").build.run(log_file, true)

or

Xcody.new.xcode_build.project("your_project.xcodeproj").build_for_testing.run
```

## Contributing

1. Fork it ( https://github.com/KazuCocoa/xcody/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
