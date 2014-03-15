require "countries/phone_numbers/version"

# Primary gems
require 'countries'
require 'phony'

# Countries::PhoneNumber
require 'countries/phone_numbers/extensions'
require 'countries/phone_numbers/detector_factory'
require 'countries/phone_numbers/detector'
require 'countries/phone_numbers/one_of_detector'
require 'countries/phone_numbers/start_with_detector'

# Gem extensions
# require 'countries/iso3166'

module Countries
  module PhoneNumbers
    extend Extensions::ClassMethods
    DATA_FILE = File.join( 'lib', 'countries', 'phone_numbers', 'detectors.yaml' )

    ##
    # Find all countries with shared country codes.
    def self.shared_country_codes
      codes = Country.all.map { |cc| Country[cc[1]].country_code }.uniq
      shared = codes.each_with_object({}){ |cc,h| h[cc] = Country.find_all_countries_by_country_code(cc) }
      shared.reject!{ |key,entry| entry.nil? or entry.count <= 1 }
      shared.each{ |cc,countries| shared[cc] = countries.map{ |c| c.name } }
    end
  
    ##
    # Find all countries with shared country codes and do not have a dedicated detector.
    def self.unresolved_country_codes
      shared_country_codes.reject{ |key,value| self.phone_number_detector_factory.detector_for? key or key == '' }
    end

  end
end

# Merge the phone number extensions into the base Country object.
require 'countries/phone_numbers/ext'
