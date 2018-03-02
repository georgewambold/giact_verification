# GiactVerification
[![Build Status](https://travis-ci.org/georgewambold/giact_verification.svg?branch=master)](https://travis-ci.org/georgewambold/giact_verification)

This gem only works for **Version 5.8.x** of GIACT's API

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'giact_verification'
```

Or install it yourself as:

    $ gem install giact_verification

## Configuration
To set up your API keys, use the configuration helper like this:

```ruby
GiactVerification.configure do |config|
  config.api_username = 'foo'
  config.api_password = 'bar'
  config.sandbox_mode = false
end
```
Setting `config.sandbox_mode = true` will post all requests to GIACT's sandbox API.

## gAuthenticate
`GiactVerification::Authenticate` takes two arguements: a [valid customer](#valid_customer) and a [valid check](#valid_check).

```ruby
GiactVerification::Authenticate.call(
  customer: {
    first_name: "Kent"
    last_name: "Beck"
    address_line1: "123 Test Dr."
    city: "Abbotsford"
    state: "MA"
    zip_code: "54321"
    phone_number: "4127982231"
    tax_id: 9876543210
    date_of_birth: Date.parse('Mar 6 1961')
  },
  check: {
    routing_number: 123456789
    account_number: 00012300089
  }
)
```

`GiactVerification::Authenticate.call()` will return a `GiactVerification::Response` object which has the following API:

```ruby
response = GiactVerification::Authenticate.call(customer: some_customer, check: some_check)

response.raw_request
#=> The XML sent to GIACT

response.raw_response
#=> The XML returned from GIACT

response.success?
# true indicates GIACT returned valid XML 
# false indicates there was some kind of error. You can then check the raw_response for details.

response.parsed_response
#=> Hash of the data GIACT returned with keys: 
# {
#  item_reference_id: String,
#  created_date: DateTime,
#  verification_response: String,
#  account_response_code: String,
#  bank_name: String,
#  account_added_date: DateTime,
#  account_last_updated_date: DateTime,
#  account_closed_date: DateTime,
#  funds_confirmation_result: String,
#  customer_response_code: String
# }
```

## <a name="valid_customer">Valid Customer Attributes</a>
The following are valid customer fields. Please note that the required fields noted below only represent the bare minimum. Some GIACT services will require additional fields.

* **name_prefix:** 1-4 characters
* **first_name:** 2-40 characters *REQUIRED*
* **middle_name:** 1-40 characters
* **last_name:** 2-40 characters *REQUIRED*
* **name_suffix:** 1-4 characters
* **address_line1:** 2-40 characters *REQUIRED*
* **address_line2:** 1-40 characters
* **city:** 2-25 characters *REQUIRED*
* **state:** 2 characters, valid US state or Candian province *REQUIRED*
* **zip_code:** 5 or 7 or 10 characters, valid US or Canadian postal code *REQUIRED*
* **country:** Either 'US' or 'CA', defaults to 'US'
* **phone_number:** 10 numeric characters, can't start with 0, no dashes
* **tax_id:** Social security number or business ein *REQUIRED*
* **date_of_birth:** Date, DateTime or an object that responds to :strftime *REQUIRED*
* **drivers_license_number:** 1-28 numeric characters
* **drivers_license_state:** 2 characters, valid US state or Candian province
* **email_address:** 1-100 characters
* **current_ip_address:** 1-15 characters
* **mobile_consent_record_id:** Numeric, unspecified length
* **alternative_id_type:** Must be one of the following: 'UsaMilitaryId', 'UsaStateId', 'PassportUsa', 'PassportForeign', 'UsaResidentAlienId', 'StudentId', 'TribalId', 'DlCanada', 'DlMexico', or 'OtherForeignId'
* **alternative_id_issuer:** 1-50 characters
* **alternative_id_number:** 1-50 numeric characters
* **domain:** 1-100 characters

## <a name="valid_check">Valid Check Attributes</a>
The following are valid check fields:

* **routing_number:** 9 numeric characters *REQUIRED*
* **account_number:** 4-17 numeric characters *REQUIRED*
* **check_number:** numeric, unspecified length
* **check_amount:** float or float-like string (eg. '100.01')
* **account_type:** one of the following: 'Checking', 'Savings' or 'Other'

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/georgewambold/giact_verification. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake` to run the tests.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
