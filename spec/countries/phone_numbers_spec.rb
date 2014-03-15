require 'spec_helper'
require 'countries/phone_numbers'

describe Countries::PhoneNumbers do
  
  it_behaves_like 'a phone number finder'
  it_behaves_like 'a phone number formatter'

  Countries::PhoneNumbers.unresolved_country_codes.each do |country_code, countries|
    pending "Need to resolve CC: #{country_code} for #{countries.join(', ')}."
  end
  
  (Country.all.map{ |country| country[1] } - TEST_DATA.keys).each do |alpha2|
    pending "No tests for #{Country[alpha2].name} (#{alpha2})."
  end
  
end
