class Countries::PhoneNumbers::StartWithCountryDetector < Countries::PhoneNumbers::CountryDetector

  def initialize( config )
    super config
    self.country_codes = config['start_with']
    
    # Standardise all country codes
    self.country_codes.each do |alpha2, codes|
      self.country_codes[alpha2.to_s] = codes.map{ |code| code.to_s }
    end
  end
  
protected

  def find_alpha2 number
    # Split the given number unless it is an array (assumes that it has already been split)
    number = Country.tokenize_phone_number(number) unless number.is_a?(Array)
    number = number.drop(1).join
  
    # Loop over all prefixes
    self.country_codes.each do |alpha2, codes|
      codes.each do |prefix|
        return alpha2 if number.start_with? prefix.to_s
      end
    end
    
    return self.default
  end

end
