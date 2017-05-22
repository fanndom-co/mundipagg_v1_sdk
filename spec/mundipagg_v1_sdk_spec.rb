require 'spec_helper'

describe MundipaggV1Sdk do
  let(:wrong_customer) do
    {
      email: "user@example.com"
    }
  end
  let(:customer) do
    {
      "name": "Luke Skywalker",
      "email": "lskywalkder@r2d2.com",
      "phones": {
    	"home_phone": {
          "country_code": "55",
    	  "number": "000000000",
    	  "area_code": "021"
    	}
       },
      "document": "26224451990",
      "type": "individual",
      "birthdate": "2000-09-09",
      "metadata": {
        "id": "my_customer_id"
      }
    }
  end
  it "should not create customer" do
    expect{ MundipaggV1Sdk::Customer.create(nil) }.to raise_error(Exception)
  end
  it "should not create customer" do
    expect{ MundipaggV1Sdk::Customer.create(wrong_customer) }.to raise_error(Exception)
  end
  describe "#create" do
    before do
      @created_customer = MundipaggV1Sdk::Customer.create(customer)
    end

    subject { @created_customer }

    it "should exist a created customer" do
      expect( subject ).to_not be_nil
    end
    it "should have an id in the returned customer" do
      expect( subject["id"] ).to_not be_nil
    end
  end
end
