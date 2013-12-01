class Countries::PhoneNumbers::CountryDetector

  attr_accessor :country_codes, :applies_to, :default
  
  def self.build config
    # Build a new config tool based on the given strategy
    return case
      when config.include?('start_with')
        Countries::PhoneNumbers::StartWithCountryDetector.new config
      when config.include?('one_of')
        Countries::PhoneNumbers::OneOfCountryDetector.new config
      else
        Countries::PhoneNumbers::CountryDetector.new config
      end
  end
  
  def initialize config
    self.applies_to = config['applies_to'].to_s
    self.default = config['default'].to_s
  end

  def find_all_by_phone_number number
    [ find_by_phone_number(number) ]
  end
  
  def find_by_phone_number number
    return Country.find_by_alpha2 find_alpha2(number)
  end
  
  def find_all_countries_by_phone_number number
    [ find_country_by_phone_number(number) ]
  end
  
  def find_country_by_phone_number number
    return Country[find_alpha2(number)]
  end
  
protected

  def find_alpha2(number)
    self.default
  end
  
end
