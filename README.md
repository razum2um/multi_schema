# MultiSchema


Packed into a gem from here:
http://timnew.github.com/blog/2012/07/17/use-postgres-multiple-schema-database-in-rails/

Thanks. @TimNew!

## Installation

Add this line to your application's Gemfile:

    gem 'multi_schema'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install multi_schema

## Usage

You can use it as the utility class in the old-fashioned way:

```ruby
MultiSchema.with_in_schemas :except => :public do
  # Play around the data in one schema
end
```
Or you can use it in a DSL-like way:
```ruby
class SomeMigration < ActiveRecord::Migration
  include MultiSchema

  def change
    with_in_schemas :except => :public do
      # Play around the data in one schema
    end
  end
end
```

* with_in_schemas yield all user schemas in the database
* with_in_schemas :only => %w(schema1 schema2) populates all given schemas.
* with_in_schemas :except => %w(schema1 schema2) populates all except given schemas.
* with_in_schemas :except => [:public] is equivalent to with_in_schemas :except => ['public']
* with_in_schemas :only => [:public] is equivalent to with_in_schemas :only => :public and equivalent to with_in_schemas :public
* with_in_schemas :except => [:public] is equivalent to with_in_schemas :except => :public

## TODO

tests, ci...

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
