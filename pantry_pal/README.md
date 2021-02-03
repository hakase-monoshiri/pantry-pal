# PantryPal
Pantry Pal is a CLI application that manages a virtual "pantry", "shopping list" and "recipie list"

Users can add or remove items from thier pantry either individually, or as a comma separated list of items.

They can create recipes or search and save them from the Edamam API. 
They can also search for unique recipies based on what already exists in thier pantry

They also have a shopping list, which can be made manually, or the ingredients from a saved recipe can be imported directly to a shopping list.
Furthermore, the shoppinglist will not import ingredients that are already in the pantry.

*note: Because of the way Edamam API manages ingredients (it often includes the unit type and quantity as part of the ingredient name), 
duplicate ingredients may appear in shopping lits, pantry and other places. 
For this reason, this build stores ingredients as strings instead of ingredient objects
(no point making a new class with a bunch of objects when the data it's built off of is flawed)
While i could have used a different API (probably Spoonacular) i don't want to pay for it, or be limited to a really low call quota.
So it is, what it is.



The API used for recipe search functions in this gem is:
https://developer.edamam.com/edamam-docs-recipe-api

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'pantry_pal'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install pantry_pal

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).


If the recipe search function breaks, check the API doccumentaion at https://developer.edamam.com/edamam-docs-recipe-api. 

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/pantry_pal. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/pantry_pal/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the PantryPal project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/pantry_pal/blob/master/CODE_OF_CONDUCT.md).
