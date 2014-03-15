require 'spec_helper'
require 'countries/phone_numbers/ext_finders'
require 'countries/phone_numbers/ext_formatters'

describe ISO3166::Country do

  subject { Country }
  
  it_behaves_like 'a phone number finder'
  it_behaves_like 'a phone number formatter'
  
end
