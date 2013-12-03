class Countries::PhoneNumbers::OneOfDetector < Countries::PhoneNumbers::Detector

  def initialize( config )
    super config
    self.country_codes = config['one_of']
    
    # Standardise all country codes
    self.country_codes.each do |alpha2, codes|
      self.country_codes[alpha2.to_s] = codes.map{ |code| code.to_s }
    end
  end
  
protected

  def find_alpha2 number
    # Split the given number unless it is an array (assumes that it has already been split)
    number = Country.tokenize_phone_number(number) unless number.is_a?(Array)
  
    # Loop over all prefixes
    self.country_codes.each do |alpha2, codes|
      return alpha2.to_s if codes.include? number[1]
    end
    
    return self.default
  end

end
