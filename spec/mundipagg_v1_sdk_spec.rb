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

  let(:wrong_card) do
    {
      email: "user@example.com"
    }
  end

  let(:card) do
    {
      "number": "4716020721549330",
      "holder_name": "Tony Stark",
      "exp_month": 1,
      "exp_year": 18,
      "cvv": "331",
      "billing_address": {
        "street": "Malibu Point",
        "number": "10880",
        "zip_code": "90265",
        "neighborhood": "Central Malibu",
        "city": "Malibu",
        "state": "CA",
        "country": "US"
      },
      "options": {
        "verify_card": true
      }
    }
  end

  describe "MundipaggV1Sdk::Customer" do

    before do
      @created_customer = MundipaggV1Sdk::Customer.create( customer )
      @listed_customers = MundipaggV1Sdk::Customer.list
    end

    describe "MundipaggV1Sdk::Customer#create" do

      context "Failing creation" do

        it "should not create Customer" do
          expect{ MundipaggV1Sdk::Customer.create(nil) }.to raise_error(Exception)
        end

        it "should not create Customer" do
          expect{ MundipaggV1Sdk::Customer.create(wrong_customer) }.to raise_error(Exception)
        end

      end

      context "Successful creation" do

        subject { @created_customer }

        it "should exist a created customer" do
          expect( subject != nil && subject["id"] != nil ).to eq(true)
        end

      end

    end

    describe "MundipaggV1Sdk::Customer#list" do

      context "Successful listing" do

        subject { @listed_customers }

        it "should exist a list of Customers" do
          expect( subject ).to_not be_nil
        end

      end

    end

  end

  describe "MundipaggV1Sdk::Card" do

    before do
      @created_customer  = MundipaggV1Sdk::Customer.create( customer )
      @created_card      = MundipaggV1Sdk::Card.create(@created_customer["id"], card)
      @retrieved_card    = MundipaggV1Sdk::Card.retrieve(@created_customer["id"], @created_card["id"])
      @listed_cards      = MundipaggV1Sdk::Card.list(@created_customer["id"])
      @deleted_cards     = []
      @listed_cards.each do |c|
        @deleted_cards << MundipaggV1Sdk::Card.delete(@created_customer["id"], c["id"])
      end
    end

    describe "MundipaggV1Sdk::Card#create" do

      context "Failing creation" do

        it "should not create Card" do
          expect{ MundipaggV1Sdk::Card.create(nil, nil) }.to raise_error(Exception)
        end

        it "should not create Card" do
          expect{ MundipaggV1Sdk::Card.create(nil, wrong_card) }.to raise_error(Exception)
        end

        it "should not create Card" do
          expect{ MundipaggV1Sdk::Card.create("", wrong_card) }.to raise_error(Exception)
        end

        it "should not create Card" do
          expect{ MundipaggV1Sdk::Card.create("", wrong_card) }.to raise_error(Exception)
        end

      end

      context "Successful creation" do

        subject { @created_card }

        it "should exist a created Card" do
          expect( subject != nil && subject["id"] != nil ).to eq(true)
        end

      end

    end

    describe "MundipaggV1Sdk::Card#retrieve" do

      context "Failing retrieval" do

      end

      context "Successful retrieval" do

        subject { @retrieved_card }

        it "should exist a retrieved Card" do
          expect( subject != nil && subject["id"] != nil ).to eq(true)
        end

      end

    end

    describe "MundipaggV1Sdk::Card#list" do

      context "Successful listing" do

        subject { @listed_cards }

        it "should exist a list of customer Cards" do
          expect( subject ).to_not be_nil
        end

      end

    end

    describe "MundipaggV1Sdk::Card#delete" do

      context "Successful deletion" do

        subject { @deleted_cards }

        it "all cards should be deleted" do
          expect( subject ).to all( satisfy{ |c| c["status"] == "deleted" } )
        end

      end

    end

  end

end
