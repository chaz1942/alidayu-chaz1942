require "alidayu/version"
require 'cgi'
require 'base64'
require 'openssl'
require 'securerandom'
require 'json'
require 'net/http'

module Alidayu
  # Your code goes here...
  class << self
    attr_accessor :access_key_id, :access_key_secrete

    # required params
    #
    # PhoneNumbers
    # SignName
    # TemplateCode
    # TemplateParam
    def send_text_message params
      params.map { |key, value| params[key] = value.to_json.to_s if value.class.to_s == Hash.name }
      params.merge!(
          {Action: 'SendSms',
           Version: '2017-05-25',
           RegionId: 'cn-hangzhou'})
      JSON.parse request params

    end

    def get_signature params

      stander_string = generate_stander_string(params)
      construct_string = 'GET&' + CGI.escape('/') + '&' + CGI.escape(stander_string)
      digest = OpenSSL::Digest.new('sha1')
      key = access_key_secrete + '&'
      Base64.encode64(OpenSSL::HMAC.digest(digest, key, construct_string)).gsub(/\n/, '')
    end

    private

    def generate_stander_string params
      str = ''
      keys = params.keys.sort
      keys.each do |key|
        str += "#{CGI.escape(key.to_s)}=#{CGI.escape(params[key.to_sym])}&"
      end
      str.gsub(/\&$/, '')
    end



    def get_utc_timestamp
      Time.now.utc.strftime("%Y-%m-%dT%H:%M:%SZ")
    end

    def get_nonce
      SecureRandom.uuid
    end

    def create_params params
      rest_params = {
          AccessKeyId: access_key_id,
          Timestamp: get_utc_timestamp,
          SignatureMethod: 'HMAC-SHA1',
          SignatureVersion: '1.0',
          SignatureNonce: get_nonce,
          Format: "JSON"
      }
      params.merge rest_params
    end

    def get_request_url params
      require_host = 'http://dysmsapi.aliyuncs.com/?'

      final_params = create_params params
      signature = get_signature final_params
      final_params.merge!({Signature: signature})
      final_params.map do |key, value|
        require_host += "#{CGI.escape(key.to_s)}=#{CGI.escape(value)}&"
      end
      require_host.gsub(/\&$/, '')
    end

    def request params
      url = URI(get_request_url(params))
      response = Net::HTTP.get_response(url)
      response.body
    end

  end
end
