module MundipaggV1Sdk

  require "base64"
  require 'rest-client'
  require 'json'

  @@end_point = "https://api.mundipagg.com/core/v1"

  @@SERVICE_HEADERS = {
    :Authorization  => "Basic #{::Base64.encode64("sk_test_WMdm1KYsYXuQVj1n:")}".strip,
    :Accept         => 'application/json',
    :"Content-Type" => 'application/json'
  }

  # funcao de post generica
  def postRequest(payload, url)
    begin
      response = RestClient.post("#{@@end_point}#{url}", payload, headers=@@SERVICE_HEADERS)
    rescue RestClient::ExceptionWithResponse => err
      handle_error_response(err)
      response = err.response
    end

    JSON.load response
  rescue JSON::ParserError => err
    response
  end

  # funcao patch generica
  def patchRequest(payload, url)
    begin
      response = RestClient.patch("#{@@end_point}#{url}", payload, headers=@@SERVICE_HEADERS)
    rescue RestClient::ExceptionWithResponse => err
      handle_error_response(err)
      response = err.response
    end

    JSON.load response
  rescue JSON::ParserError => err
    response
  end

  # funcao de delete generica
  def deleteRequest(url)
    begin
      response = RestClient.delete("#{@@end_point}#{url}", headers=@@SERVICE_HEADERS)
    rescue RestClient::ExceptionWithResponse => err
      handle_error_response(err)
      response = err.response
    end

    JSON.load response
  rescue JSON::ParserError => err
    response
  end

  # funcao get generica
  def getRequest(url)
    begin
      response = RestClient.get("#{@@end_point}#{url}", headers=@@SERVICE_HEADERS)
    rescue RestClient::ExceptionWithResponse => err
      handle_error_response(err)
      response = err.response
    end

    v = JSON.load response
    return v["data"] if v["data"] != nil
    return v
  rescue JSON::ParserError => err
    response
  end

  def handle_error_response(err)
    # MundipaggV1Sdk::AuthenticationError.new
    err_response = JSON.load(err.response)
    puts err_response["message"]
    puts JSON.pretty_generate(err_response["errors"])
    raise(::Exception.new( err_response["message"] ))
  end

end

class MundipaggV1Sdk::Customer

  extend MundipaggV1Sdk

  def self.create(customer)
    customer = {} if customer == nil
    postRequest(customer.to_json, "/customers")
  end

  def self.retrieve(customer_id)
    ArgumentError.new("Customer id should be a String") if customer_id == nil
    getRequest("/customers/#{customer_id}")
  end

  def self.list
    getRequest("/customers")
  end

end

class MundipaggV1Sdk::Card

  extend MundipaggV1Sdk

  def self.create(customer_id, card)
    card = {} if card == nil
    postRequest(card.to_json, "/customers/#{customer_id}/cards")
  end

  def self.retrieve(customer_id, card_id)
    ArgumentError.new("Customer id should be a String") if customer_id == nil
    ArgumentError.new("Card can't be nil") if card_id == nil
    getRequest("/customers/#{customer_id}/cards/#{card_id}")
  end

  def self.list(customer_id)
    ArgumentError.new("Customer id should be a String") if customer_id == nil
    getRequest("/customers/#{customer_id}/cards")
  end

  def self.delete(customer_id, card_id)
    ArgumentError.new("Customer id should be a String") if customer_id == nil
    ArgumentError.new("Card id should be a String") if card_id == nil
    deleteRequest("/customers/#{customer_id}/cards/#{card_id}")
  end

end

class MundipaggV1Sdk::Charge

  extend MundipaggV1Sdk

  def self.create(charge)
    charge = {} if charge == nil
    postRequest(charge.to_json, "/charges")
  end

  def self.retrieve(charge_id)
    ArgumentError.new("Charge id should be a String") if charge_id == nil
    getRequest("/charges/#{charge_id}")
  end

end

class MundipaggV1Sdk::Plan

  extend MundipaggV1Sdk

  def self.create(plan)
    plan = {} if plan == nil
    postRequest(plan.to_json, "/plans")
  end

  def self.retrieve(plan_id)
    ArgumentError.new("Plan id should be a String") if plan_id == nil
    getRequest("/plans/#{plan_id}")
  end

end

class MundipaggV1Sdk::Order

  extend MundipaggV1Sdk

  def self.create(order)
    order = {} if order == nil
    postRequest(order.to_json, "/orders")
  end

end

class MundipaggV1Sdk::Address

  extend MundipaggV1Sdk

  def self.create(address)
    address = {} if address == nil
    postRequest(address.to_json, "/addresses")
  end

end

class MundipaggV1Sdk::Subscription

  extend MundipaggV1Sdk

  def self.create(subscription)
    subscription = {} if subscription nil
    postRequest(subscription.to_json, "/subscriptions")
  end

end

class MundipaggV1Sdk::Invoice

  extend MundipaggV1Sdk

  def self.create(subscription_id, cycle_id)
    ArgumentError.new("Subscription id should be a String") if subscription_id == nil
    ArgumentError.new("Cycle id should be a String") if cycle_id == nil
    invoice = {}
    postRequest(invoice.to_json, "/subscriptions/#{subscription_id}/cycles/#{cycle_id}/pay")
  end

end

class MundipaggV1Sdk::Token

  extend MundipaggV1Sdk

  def self.create(token)
    token = {} if token nil
    postRequest(token.to_json, "/tokens")
  end

end

class MundipaggV1Sdk::Webhook

  extend MundipaggV1Sdk

  def self.create(hook_id)
    ArgumentError.new("Webhook id should be a String") if hook_id == nil
    hook = {}
    postRequest(hook.to_json, "/tokens")
  end

end

class MundipaggV1Sdk::AuthenticationError
end
