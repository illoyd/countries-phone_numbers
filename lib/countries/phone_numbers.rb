require "countries/phone_numbers/version"

# Primary gems
require 'countries'
require 'phony'

# Country::PhoneNumber
require 'countries/phone_numbers/detector_factory'
require 'countries/phone_numbers/detector'
require 'countries/phone_numbers/one_of_detector'
require 'countries/phone_numbers/start_with_detector'

# Gem extensions
require 'countries/iso3166'

module Countries
  module PhoneNumbers
    DATA_FILE = File.join( 'lib', 'countries', 'phone_numbers', 'detectors.yaml' )
  end
end
