require 'spec_helper'

describe ISO3166::Country, '#find_*_by_phone_number' do
  subject { Country }

  # Test a bogus phone number
  it 'ignores bogus phone numbers (single digit)' do
    Country.find_country_by_phone_number( '5' ).should == nil
  end
  
  # Test another bogus phone number
  it 'ignores bogus phone numbers (text)' do
    Country.find_country_by_phone_number( 'abc' ).should == nil
  end
  
  # Test all data given in the 'TEST' block (defined in the spec helper)
  TEST_DATA.each do |alpha2, numbers|
    numbers.each do |number|
      it "recognises #{number} as #{alpha2.to_s}" do
        Country.find_country_by_phone_number(number).should_not be_nil
        Country.find_country_by_phone_number(number).alpha2.should == alpha2.to_s
      end
      it "returns only one country for #{number}" do
        Country.find_all_countries_by_phone_number(number).should have(1).country
      end
    end
  end
  
end
