require 'spec_helper'

describe MundipaggV1Sdk do
  it "should create card" do
    expect{MundipaggV1Sdk::create_card}.to output('Card Created').to_stdout
  end
end