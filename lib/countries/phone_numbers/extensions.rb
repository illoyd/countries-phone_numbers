module Countries::PhoneNumbers::Extensions

  def self.included( base )
    base.extend ClassMethods
  end
  
  def format_phone_number( number, options={} )
    Phony.formatted( number, options )
  end
  
  def format_local_phone_number( number, options={} )
    format_phone_number( number, {format: :local}.merge(options) )
  end
  
  def format_international_phone_number( number, options={} )
    format_phone_number( number, {format: :international}.merge(options) )
  end
  
  def format_national_phone_number( number, options={} )
    format_phone_number( number, {format: :national}.merge(options) )
  end
  
  module ClassMethods
    def normalize_phone_number( number )
      Phony.normalize( number )
    end
  
    def tokenize_phone_number( number )
      Phony.split( normalize_phone_number( number ) )
    end
  
    ##
    # Find the first country by the given telephone number. Returns an array of country code and data
    def find_by_phone_number( number )
      found = find_all_by_phone_number(number)
      found.nil? ? nil : found.first
    end
  
    ##
    # Find all possible countries for the given telephone number.
    # Generally we try to eliminate duplicates by using country code specific detectors.
    def find_all_by_phone_number( number )
      normalised_number = tokenize_phone_number( number )
      country_code = normalised_number.first
      
      # Is this a detector country?
      detector = phone_number_detector_factory.detector_for( country_code )
      if detector
        return detector.find_all_by_phone_number( normalised_number )
       
      # Otherwise ask the general code base for the number
      else
        return Country.find_all_by_country_code( country_code )
      end
  
    rescue
     return nil
    end
    
    ##
    # Find the first country by the given telephone number. Returns the country object itself.
    def find_country_by_phone_number( number )
      found = Country.find_all_countries_by_phone_number(number)
      found.nil? ? nil : found.first
    end
    
    ##
    # Find all possible countries for the given telephone number.
    # Generally we try to eliminate duplicates by using country code specific detectors.
    def find_all_countries_by_phone_number( number )
      normalised_number = tokenize_phone_number( number )
      country_code = normalised_number.first
      
      # Is this a detector country?
      detector = phone_number_detector_factory.detector_for( country_code )
      if detector
        return detector.find_all_countries_by_phone_number( normalised_number )
       
      # Otherwise ask the general code base for the number
      else
        return Country.find_all_countries_by_country_code( country_code )
      end
  
    rescue
     return nil
    end
    
  protected
  
    def phone_number_detector_factory
      @@phone_number_detector_factory ||= Countries::PhoneNumbers::DetectorFactory.new
    end
  end

end