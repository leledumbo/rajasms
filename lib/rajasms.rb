require "rajasms/version"
require 'httparty'

module Rajasms
  class Client
  	include HTTParty

    RAJASMS_URI = 'http://128.199.232.241'
    SMSREGULER_PATH = '/sms/smsreguler.php'
    SMSMASKING_PATH = '/sms/smsmasking.php'
    SMSSALDO_PATH = '/sms/smssaldo.php'
    SMSREGULER_CHECK_PATH = '/sms/smsregulerreport.php'
    SMSMASKING_CHECK_PATH = '/sms/smsmaskingreport.php'

  	base_uri RAJASMS_URI

  	def initialize username, api_key
  		@username = username
      @api_key  = api_key
  	end

    def reguler to, message
      send(to, message, SMSREGULER_PATH)
    end

    def masking to, message
      send(to, message, SMSMASKING_PATH)
    end

    def saldo
      response = self.class.get(SMSSALDO_PATH, build_query)
      code, data = response.body.split('|')
      {code: code, data: data}
    end

    def status(sms_id, reguler=false)
      response = self.class.get(reguler ? SMSREGULER_CHECK_PATH : SMSMASKING_CHECK_PATH, build_query(id: sms_id))
      code, data = response.body.split('|')
      {code: code, data: data}
    end

    private
    def build_query query={}
      query ||= {}
      query.merge!(username: @username, key: @api_key)
      {query: query}
    end

    def send to, message, path
      if message.length <= 480
        response = self.class.post(path, build_query(number:to, message: message))
        code, data = response.body.split('|')
        {code: code, data: data}
      else
        raise "panjang maksimum sms adalah 480 karakter, mencoba mengirim #{message.length} karakter"
      end
    end

  end
end
