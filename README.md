# Data Engineering Recombinator Challenge
##Recombinator Solution
*Billy Fortin*
*wjf136@gmail.com*

## Description
Recombinator takes in a file with a data structure such as a json file with a matrix structure. It converts the input file to and output file of a specific data structure

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'recombinator'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install recombinator

## Usage
Once installed to your local system, recombinator can be run as an exetuable gem in any directory. Within a directory within input files A_input.json, and B_input.json, run the following

> recombinator convert -f [filename_1.json] [filename_2.json]

Examples below
> recombinator convert -f A_input.json B_input.json 

To get the help menu with a set of options, run the follwing

> recombinator help


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Summary of code base
In convert.rb, I initially check the type of data structure to know whether it is in type A or Type B format.For now, these are the only two input possibilities. Converting Type_A is a matter of just converting the columns to key - array pairs where the key is the first row with the variable name. I basically take the transpose of the array, though I do it with the map method. One, I read online the map method is faster. Two, I thought it was a good way to show my familiarity with the map method.

Converting Type_B is a little trickier. First, I go through each hash and obtain the key values of that hash. I then add this to a global keys list, removing duplicates. This will be used in order to define null values in the output array. After I obtain all the keys, I parse each hash in the input array for the key. If a key exists, it returns it's value. If it does not, it returns null. I keep a running array of all values for each key from the input hashes, and as in Type_A, I create the key-array based off of the completed array.

For the CLI, I chose to go with Thor because it seemes to be in wide use as seen here (https://rubygems.org/stats). In the convert command, I take in an array of file names as defined by the -f option. This option is required. Then, I convert each file using the Convert class, calling the convert_file method to produce the converted output files.

Additionally, I use Rspec for Acceptance testing. I test each of the methods in the COnvert class, as well as test the command line interface of Thor.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/recombinator. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

