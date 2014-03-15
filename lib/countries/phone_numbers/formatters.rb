module Countries::PhoneNumbers::Formatters

  def self.included( base )
    base.extend ClassMethods
  end
  
  module ClassMethods

    def format_phone_number( number, options={} )
      Phony.formatted( Phony.normalize( number ), options )
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
  
  end

end