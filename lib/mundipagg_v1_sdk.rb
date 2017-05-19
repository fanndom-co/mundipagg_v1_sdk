class MundipaggV1Sdk
  
  @@end_point = "https://api.mundipagg.com/core/v1"
  
end

class MundipaggV1Sdk::Customer
  
  def self.create(customer_name)
    RestClient::Request.execute(method: :post, url: @@end_point+"/customers", Authorization: 'sk_test_tra6ezsW3BtPPXQa', data: {'name': customer_name}.to_json)
  end
  
end