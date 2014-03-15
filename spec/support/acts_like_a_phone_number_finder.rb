shared_examples 'a phone number finder' do |factory|

  # Test a bogus phone number
  it 'ignores bogus phone numbers (single digit)' do
    subject.find_country_by_phone_number( '5' ).should == nil
  end
  
  # Test another bogus phone number
  it 'ignores bogus phone numbers (text)' do
    subject.find_country_by_phone_number( 'abc' ).should == nil
  end
  
  # Test all data given in the 'TEST' block (defined in the spec helper)
  TEST_DATA.each do |alpha2, numbers|
    numbers.each do |number|

      it "recognises #{number} as #{alpha2}" do
        subject.find_country_by_phone_number(number).should_not be_nil
        subject.find_country_by_phone_number(number).alpha2.should == alpha2.to_s
      end

      it "returns only one country for #{number}" do
        subject.find_all_countries_by_phone_number(number).should have(1).country
      end
      
      it "recognises #{number} as plausible" do
        subject.plausible_phone_number?(number).should eq(Phony.plausible?(number))
      end
      
    end # number
  end # test data

end