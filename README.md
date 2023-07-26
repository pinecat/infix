# Infix

Infix is a simple, drop-in DSL for configuring any Ruby class.

## Installation

In your Gemfile, place the following line:

```
gem "infix", "~> 0.1"
```

The run `bundle` to install.

## Usage

To use Infix, simply require it, then include it in your class. You will be able to access your configuration options using the `infix` method on the class instance. Similarly, you use the `infix` method, and pass it a block, in order to set preferences.

```ruby
require "infix"

class Bird
  include Infix

  def initialize(name)
    @name = name
  end
end

bird = Bird.new('Swallow')

b.infix do
  type      :european
  carrying  "coconut"
  topspeed  24
end

puts b.infix[:type]     #=> Outputs 'european'
puts b.infix[:carrying] #=> Outputs 'coconut'
puts b.infix[:topspeed] #=> Outputs '24'
```

You can also have nested structues inside your infix block.

```ruby
b.infix do
  film_references do
    monty_python  true
    star_wars     "no"
  end
end

puts b.infix[:film_references][:monty_python] #=> Outputs 'true'
puts b.infix[:film_references][:star_wars] #=> Outputs 'no'
```

Infix may also be useful for defining application options in a usual location (i.e. `~`, `~/.config`, `/etc`).

```ruby
# ~/.birdrc

$bird.infix do
  type      :european
  carrying  "coconut"
  topspeed  24
end
```

```ruby
require "infix"

class Bird
  include Infix
end

$bird = Bird.new

config = File.expand_path("~/.birdrc")

require config if File.exist?(config)

puts $bird.infix #=> Outputs {:type=>:european, :carrying=>"coconut", :topspeed=>24}
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/pinecat/infix.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
