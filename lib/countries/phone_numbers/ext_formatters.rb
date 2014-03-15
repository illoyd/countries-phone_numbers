require 'countries/phone_numbers'

class ISO3166::Country
  include Countries::PhoneNumbers::Formatters
end
