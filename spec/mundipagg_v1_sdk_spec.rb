require 'spec_helper'

describe MundipaggV1Sdk do
  let(:user) do
    {
      email: "user@example.com"
    }
  end
  it "should create customer" do
    expect{ MundipaggV1Sdk::Customer.create(nil) }.to output('Card Created').to_stdout
  end
  it "should create customer" do
    expect{ MundipaggV1Sdk::Customer.create(user) }.to output('Card Created').to_stdout
  end
end
