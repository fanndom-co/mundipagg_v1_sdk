module MundipaggV1Sdk

  require "base64"
  require 'rest-client'
  require 'json'

  @@end_point = "https://api.mundipagg.com/core/v1"

  @@SERVICE_HEADERS = {
    :Authorization  => "Basic #{::Base64.encode64("#{ENV['MUNDIPAGG_SECRET_KEY']}:")}",
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

    JSON.load response
  rescue JSON::ParserError => err
    response
  end

  def handle_error_response(err)
    # MundipaggV1Sdk::AuthenticationError.new
    err_response = JSON.load(err.response)
    puts err_response["message"]
    puts JSON.pretty_generate(err_response["errors"])
    # raise(::Exception.new(err))
  end

end

class MundipaggV1Sdk::Customer

  extend MundipaggV1Sdk

  def self.create(customer)
    customer = {} if customer == nil
    postRequest(customer.to_json, "/customers")
  end

end

class MundipaggV1Sdk::Card

  extend MundipaggV1Sdk

  def self.create(card)
    card = {} if card == nil
    postRequest(card.to_json, "/customers/#{card.customer.id}/Cancel")
  end

end

class MundipaggV1Sdk::AuthenticationError
end
