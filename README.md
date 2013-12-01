# Countries::PhoneNumbers

Integrate phone number to country lookup functionality into the ever-popular [Countries](https://github.com/hexorx/countries) gem using the excellent [Phony](https://github.com/floere/phony) gem. This lets you find the country for a given phone number quickly and easily.

## Installation

Add this line to your application's Gemfile:

    gem 'countries-plus-phonenumbers'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install countries-plus-phonenumbers

## Usage

It's easy. Just use the `Country.find_country_by_phone_number(number)` or `Country.find_by_phone_number(number)` methods just like you would for any other Country search. And just like with default Country search methods, it will return either an array of data or a Country object.

Time for some examples. Let's say you need to call your best pal, President Obama in the US White House.

    country = Country.find_country_by_phone_number( '+1 202-456-1111' )
    => #<Country:0x007febbac72ad8 @data={"continent"=>"North America", "address_format"=>"{{recipient}}\n{{street}}\n{{city}} {{region}} {{postalcode}}\n{{country}}", "alpha2"=>"US", "alpha3"=>"USA", "country_code"=>"1", "currency"=>"USD", "international_prefix"=>"011", "ioc"=>"USA", "latitude"=>"38 00 N", "longitude"=>"97 00 W", "name"=>"United States", "names"=>["United States of America", "Vereinigte Staaten von Amerika", "États-Unis", "Estados Unidos", "アメリカ合衆国", "Verenigde Staten"], "translations"=>{"en"=>"United States of America", "it"=>"Stati Uniti D'America", "de"=>"Vereinigte Staaten von Amerika", "fr"=>"États-Unis", "es"=>"Estados Unidos", "ja"=>"アメリカ合衆国", "nl"=>"Verenigde Staten"}, "national_destination_code_lengths"=>[3], "national_number_lengths"=>[10], "national_prefix"=>"1", "number"=>"840", "region"=>"Americas", "subregion"=>"Northern America", "un_locode"=>"US", "languages"=>["en"], "nationality"=>"American"}> 

This gives you the normal country object. Treat it like you would any other search from the Country gem.

    country.name
    => "United States"

    country.alpha2
    => "US"

## What about countries that share the same Country Code?

When multiple countries share a single country code - for instance, the North American Number Plan (NANP) - CountryDetectors are employed to provide additional analysis and intepretation. These detectors are not perfect, but they should catch most ambiguous situations.

The detectors are configured in `country_detectors.yaml`.

## Why are there a boatload of pending specs?

Any entries in the Country gem that do not have test cases will appear as pending specs. This is to help track which countries still need solid tests. If you can help by offering some numbers to validate, please contribute!

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
