require 'spec_helper'
require 'countries/phone_numbers'

describe Countries::PhoneNumbers::DetectorFactory do
  subject { Countries::PhoneNumbers::DetectorFactory.new({}) }
  let(:applies_to)        { '1' }
  let(:one_of_prefix)     { '222' }
  let(:start_with_prefix) { '333' }
  let(:default_country)   { 'US' }
  let(:alternate_country) { 'GB' }

  let(:default_config)    { { 'applies_to' => applies_to, 'default' => default_country } }
  let(:one_of_config)     { { 'applies_to' => applies_to, 'default' => default_country, 'one_of' => { alternate_country => [ one_of_prefix ] } } }
  let(:start_with_config) { { 'applies_to' => applies_to, 'default' => default_country, 'start_with' => { alternate_country => [ start_with_prefix ] } } }

  let(:default_detector)  { Countries::PhoneNumbers::Detector.new(default_config) }
  
  describe '.new' do

    context 'using a config file' do
      subject { Countries::PhoneNumbers::DetectorFactory.new(Countries::PhoneNumbers::DATA_FILE) }
      it 'loads the config file' do
        expect( subject.config ).not_to be_empty
      end
      it 'starts with no detectors' do
        expect( subject.detectors ).to be_empty
      end
    end

    context 'using a config hash' do
      let(:config) { { applies_to => default_config } }
      subject { Countries::PhoneNumbers::DetectorFactory.new(config) }
      it 'saves the config' do
        expect( subject.config ).to eq(config)
      end
      it 'starts with no detectors' do
        expect( subject.detectors ).to be_empty
      end
    end

  end

  describe '#load_config_file' do
    it 'loads a config file' do
      expect{ subject.load_config_file( Countries::PhoneNumbers::DATA_FILE ) }.to change{subject.config.size}.from(0)
    end
  end
  
  describe '#add_config' do
    before { subject.detectors[applies_to] = default_detector }
    
    it 'adds a new config' do
      expect{ subject.add_config(default_config) }.to change{subject.config.size}.by(1)
    end
    
    it 'stores config by key' do
      subject.add_config(default_config)
      expect( subject.config ).to include(applies_to)
    end
    
    it 'saves config by key' do
      subject.add_config(default_config)
      expect( subject.config[applies_to] ).to be default_config
    end
    
    it 'deletes the existing detector' do
      expect{ subject.add_config(default_config) }.to change{ subject.detectors[applies_to] }.to(nil)
    end
  end
  
  describe '#detector_for?' do
    it 'detects config' do
      expect{ subject.add_config(default_config) }.to change{ subject.detector_for? applies_to }.from(false).to(true)
    end
  end
  
  describe '#detector_for' do
    before do
      subject.add_config( default_config )
    end

    it 'reuses an existing detector' do
      subject.detectors[applies_to] = default_detector
      expect(subject.detector_for(applies_to)).to eq(default_detector)
    end
    
    it 'creates a new detector on demand' do
      subject.add_config( default_config )
      expect{ subject.detector_for(applies_to) }.to change{ subject.detectors[applies_to] } 
    end
    
    it 'returns nil when no detector configured' do
      expect( subject.detector_for('2') ).to be_nil
    end
  end
  
  describe '#build_detector' do
    it 'returns a generic detector' do
      expect( subject.send(:build_detector, default_config) ).to be_a(Countries::PhoneNumbers::Detector)
    end
    
    it 'returns a one-of detector' do
      expect( subject.send(:build_detector, one_of_config) ).to be_a(Countries::PhoneNumbers::OneOfDetector)
    end
    
    it 'returns a start-with detector' do
      expect( subject.send(:build_detector, start_with_config) ).to be_a(Countries::PhoneNumbers::StartWithDetector)
    end
  end

end
