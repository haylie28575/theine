[![Build Status](https://magnum.travis-ci.com/access-development/api-ruby.svg?token=T9pynazhFyqzCqj2LUNj&branch=master)](https://magnum.travis-ci.com/access-development/api-ruby) [![Code Climate](https://codeclimate.com/repos/5466a5ce69568076f20003de/badges/9bf8e7713208de5ce932/gpa.svg)](https://codeclimate.com/repos/5466a5ce69568076f20003de/feed)[![Coverage Status](https://coveralls.io/repos/access-development/api-ruby/badge.svg?branch=master&service=github&t=Cvep6a)](https://coveralls.io/github/access-development/api-ruby?branch=master)

# Access API

A ruby wrapper for the Access API

## Installation

```ruby
  gem 'access', '~> 2.0.0'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install access

## Setup

###Config setup

You can configure the following options:

  - `access_token` **Required**
  - `api_environment`: Set as `'demo'` or `'production'`. Default is `'demo'`.
  - `return_json`: Set as `'true'` or `'false'`. Default is `'false'` return ruby objects.
  - `hashify`: Set as `'true'` or `'false'`. Default is `'false'` return a hashed version of the json response if `return_json` is set to 'true'.
  - `access_timeout`: Set as a number. Default to `'10'`.
  - `access_debug_output`: Set as a string `'true'` or '`false`'. Default is '`false`'. When '`true`' it will write out the raw request response from the httparty call.

#### Config via Environment Variables

You can set config settings by creating environment variables called:

`ENV['ACCESS_TOKEN']`, `ENV['ACCESS_ENVIRONMENT']`, `ENV['ACCESS_RETURN_JSON']`, `ENV['ACCESS_HASHIFY']`, `ENV['ACCESS_TIMEOUT']`, `ENV['ACCESS_DEBUG_OUTPUT']`.

#### Config via Initializer

You can also create an initializer file to set up a config

```ruby
Access.configure do |config|
  config.access_token = ENV['ACCESS_TOKEN']
end
```

You can also set them one at a time

`Access.config.access_token = ENV['ACCESS_TOKEN']`

### Config via Params

`api_environment` can be overwritten by passing in by passing the param `api_environment` to the end of any call that accepts options.

`access_timeout` can be overwritten by passing in by passing the param `access_timeout` to the end of any call that accepts options.

`access_token` can be overwritten by passing in by passing the param `access_token` to the end of any call that accepts options.

`return_json` can be overwritten by passing in by passing the param `return_json` to the end of any call that accepts options.

`hashify` can be overwritten by passing in by passing the param `hashify` to the end of any call that accepts options.

`access_debug_output` can be overwritten by passing in by passing the param `access_debug_output` to the end of any call that accepts options.

###Making Calls

####Offer

```ruby
Access::Offer.search options, member_key: **your-member-key**
```

```ruby
Access::Offer.find **offer_key**, options, member_key: **your-member-key**
```

####Store

```ruby
Access::Store.search options, member_key: **your-member-key**
```

```ruby
Access::Store.find **store_key**, options, member_key: **your-member-key**
```

```ruby
Access::Store.national options, member_key: **your-member-key**
```

####Location

```ruby
Access::Location.search options, member_key: **your-member-key**
```

```ruby
Access::Location.find **location_key**, options, member_key: **your-member-key**
```

####Category

```ruby
Access::Category.search options, member_key: **your-member-key**
```

```ruby
Access::Category.find **category_key**, options, member_key: **your-member-key**
```

####Autocomplete

```ruby
Access::Autocomplete.search options
```

```ruby
Access::Autocomplete.search_stores options
```

```ruby
Access::Autocomplete.search_categories options
```

```ruby
Access::Autocomplete.search_offers options
```

```ruby
Access::Autocomplete.search_locations options
```

####Redeem

```ruby
Access::Redeem.redeem_offer **key**, nil, options, member_key: **your-member-key**
```

```ruby
Access::Redeem.redeem_offer **offer_key**, **redeem_type**, options, member_key: **your-member-key**
```

####Member

####City Savings

```ruby
Access::CitySavings.search_city_savings options, member_key: **your-member-key**
```

####Channel

```ruby
Access::Channel.search options
```

```ruby
Access::Channel.find **channel_key**, options
```

####Campaign

```ruby
Access::Campaign.search options
```

```ruby
Access::Campaign.find **campaign_key**, options
```

###Spot

```ruby
Access::Spot.search_by_channel **channel_key**, options
```

```ruby
Access::Spot.search_by_campaign **campaign_key**, options
```

```ruby
Access::Spot.find **spot_key**, options
```

###Internal Admin only Calls

###Filter

```ruby
Access::Filter.search options
```

```ruby
Access::Filter.find **filter_key**, options
```

####Report

```ruby
Access::Report.all_usage options
```

```ruby
Access::Report.usage options
```

```ruby
Access::Report.usage_other **token**, options
```

####Token

```ruby
Access::Token.search options
```

```ruby
Access::Token.find **token**, options
```

####Oauth Application

```ruby
Access::OauthApplication.search options
```

```ruby
Access::OauthApplication.find **application_id**, options
```

```ruby
Access::OauthApplication.search_tokens **application_id**, options
```

```ruby
Access::OauthApplication.find_token **application_id**, **token_id**, options
```

```ruby
Access::OauthApplication.create_token **application_id**, options
```

```ruby
Access::OauthApplication.create **application_id**, options
```

```ruby
Access::OauthApplication.update **application_id**, options
```

```ruby
Access::OauthApplication.delete **application_id**, options
```

####Verify

```ruby
  Access::Verify.token options
```

```ruby
  Access::Verify.filter options
```

####AMT

Need amt permission scope for your application before you can access these api's

```ruby
# pass in an array of members you want to import with the required parameters:
# https://docs.accessdevelopment.com/amt/importing-members.html#overview
members_array = [{organization_customer_identifier: 'example', program_customer_identifier: 'example', member_customer_identifier: 'example' }]
a = Access::Amt.import(members_array)
```

```ruby
a = Access::Amt.list()
```
a = Access::Amt.show(**import_id**)
```ruby

```

## Contributing

1. Fork it ( https://github.com/access-development/api-ruby/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

### Running the Tests

`ACCESS_TOKEN=**your-access-token** rake`

`ACCESS_TOKEN=*your-access-token** guard`

or add your environment variables to a `.env` file and run the test simply with `rake` or `guard`

### Running the Gem in Console

`ACCESS_TOKEN=*your-access-token** ruby bin/console`

or add your environment variables to a `.env` file and run `ruby bin/console`
