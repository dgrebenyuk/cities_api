## Installation

Clone this repo:

    $ git clone git@github.com:dgrebenyuk/cities_api.git

Then execute:

    $ bundle install

Create local DB config

    $ cd ./cities_api/config
    $ cp database.yml.example database.yml

Edit `database.yml` file to fit you local settings.

Create databases and run migrations

    $ rails db:create
    $ rails db:migrate

Run seeds to populate DB with some data

    $ rails db:seed

Start server

    $ rails s

## Swagger

Generate swagger json by running

    $ RAILS_ENV=test rake rswag:specs:swaggerize

Then go to http://localhost:3000/api-docs

## RSpec

Current functionality is covered by rspec tests.

    $ bundle
    $ rspec

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dgrebenyuk/cities_api.

## License

The API application is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
