require 'countries'
require 'phony'

class ISO3166::Country

  def self.normalize_phone_number( number )
    Phony.normalize( number )
  end

  def self.tokenize_phone_number( number )
    Phony.split( normalize_phone_number( number ) )
  end

  ##
  # Find the first country by the given telephone number. Returns an array of country code and data
  def self.find_by_phone_number( number )
    found = find_all_by_phone_number(number)
    found.nil? ? nil : found.first
  end

  ##
  # Find all possible countries for the given telephone number.
  # Generally we try to eliminate duplicates by using country code specific detectors.
  def self.find_all_by_phone_number( number )
    normalised_number = tokenize_phone_number( number )
    
    # Is this a detector country?
    detector = phone_number_detectors[normalised_number.first]
    if detector
      return detector.find_all_by_phone_number( normalised_number )
     
    # Otherwise ask the general code base for the number
    else
      return self.find_all_by_country_code( normalised_number.first )
    end

  rescue
   return nil
  end
  
  ##
  # Find the first country by the given telephone number. Returns the country object itself.
  def self.find_country_by_phone_number( number )
    found = find_all_countries_by_phone_number(number)
    found.nil? ? nil : found.first
  end
  
  ##
  # Find all possible countries for the given telephone number.
  # Generally we try to eliminate duplicates by using country code specific detectors.
  def self.find_all_countries_by_phone_number( number )
    normalised_number = tokenize_phone_number( number )
    
    # Is this a detector country?
    detector = phone_number_detector_for normalised_number.first
    if detector
      return detector.find_all_countries_by_phone_number( normalised_number )
     
    # Otherwise ask the general code base for the number
    else
      return self.find_all_countries_by_country_code( normalised_number.first )
    end

  rescue
   return nil
  end

  ##
  # Get the requested phone number detector based on the phone number's prefix.
  def self.phone_number_detector_for( prefix )
    prefix = prefix.to_s
    detector = phone_number_detectors[ prefix ]
    if detector.is_a? Hash
      detector = Countries::PhoneNumbers::CountryDetector.build( detector )
      phone_number_detectors[ prefix ] = detector
    end
    detector
  end
  
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
    self.shared_country_codes.reject{ |key,value| self.phone_number_detectors.keys.include? key or key == '' }
  end
  
protected

  ##
  # Collection of country detectors. Detectors are instantiated only when first needed.
  def self.phone_number_detectors
    @@phone_number_detectors ||= load_phone_number_detector_config
  end
  
  ##
  # Load phone number detector configuration.
  def self.load_phone_number_detector_config
    filename = File.join( 'lib', 'countries', 'phone_numbers', 'country_detectors.yaml' )
    config = {}
    File.open( filename ) do |file|
      YAML.load_documents( file ) do |doc|
        config[doc['applies_to'].to_s] = doc
      end
    end
    config
  end
  
end
