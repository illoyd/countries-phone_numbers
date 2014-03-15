shared_examples 'a phone number formatter' do |factory|

  # Test all data given in the 'TEST' block (defined in the spec helper)
  TEST_DATA.each do |alpha2, numbers|
    numbers.each do |number|

      it "formats #{number} internationally" do
        expected = Phony.format(Phony.normalize(number), format: :international)
        subject.format_international_phone_number(number).should eq(expected)
      end
      
      it "formats #{number} nationally" do
        expected = Phony.format(Phony.normalize(number), format: :national)
        subject.format_national_phone_number(number).should eq(expected)
      end
      
    end # number
  end # test data

end