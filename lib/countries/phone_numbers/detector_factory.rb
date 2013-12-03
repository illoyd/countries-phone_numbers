class Countries::PhoneNumbers::DetectorFactory

  attr_accessor :config, :detectors

  def initialize( config=Countries::PhoneNumbers::DATA_FILE )
    @config    = config.is_a?(Hash) ? config : {}
    @detectors = {}
    load_config_file( config ) if config.is_a?(String)
  end
  
  def load_config_file( filename )
    File.open( filename ) do |file|
      YAML.load_documents( file ) { |doc| add_config( doc ) }
    end
  end
  
  def add_config( cc )
    key = cc['applies_to'].to_s
    config[key] = cc
    detectors.delete(key)
  end
  
  def detector_for?( prefix )
    config.include? prefix.to_s
  end
  
  def detector_for( prefix )
    prefix = prefix.to_s
    if detector_for? prefix
      detectors[prefix] = build_detector( config[prefix] ) unless detectors.include? prefix
    end
    return detectors[prefix]
  end
  
  protected
  
  def build_detector( config )
    # Build a new config tool based on the given strategy
    return case
      when config.include?('start_with')
        Countries::PhoneNumbers::StartWithCountryDetector.new config
      when config.include?('one_of')
        Countries::PhoneNumbers::OneOfCountryDetector.new config
      else
        Countries::PhoneNumbers::Detector.new config
      end
  end

end