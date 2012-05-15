require 'curb'
require 'iconv'

module Paygent
  class Request
    attr_accessor :_params, :body_str, :header_str, :response_code, :request, :process_id

    def initialize(option={})
      self._params ||= {}
      self._params.update(option)
      self.process_id = (rand * 100000000).to_i
      self
    end

    def valid?
    end

    def replaceTelegramKana
    end

    def validateTelegramLengthCheck
    end

    def reqPut(key, value)
      _params ||= {}
      _params[key.to_sym] = value
    end

    def reqGet(key)
      params[key.to_sym]
    end

    def params
      {
        :merchant_id => Paygent.merchant_id,
        :connect_id => Paygent.default_id,
        :connect_password => Paygent.default_password,
        :limit_count => Paygent.select_max_cnt,
        :telegram_version => Paygent.telegram_version,
      }.merge(_params || {})
    end

    def params_str
      params.map{|f,k| "#{Curl::Easy.new.escape(f)}=#{Curl::Easy.new.escape(k)}"}.join('&')
    end

    def post
      telegram_kind = params[:telegram_kind]
      base_url = Paygent::Service.get_url_with_telegram_kind(params[:telegram_kind])
      log("Can't found related paygent URL with #{telegram_kind}") unless base_url

      url = "#{base_url}?#{params_str}"
      c = Curl::Easy.new(url)
      c.cacert          = Paygent.ca_file_path
      c.cert            = Paygent.client_file_path
      c.certpassword    = Paygent.cert_password
      c.connect_timeout = Paygent.timeout
      c.verbose         = true
      c.ssl_verify_host = false
      c.multipart_form_post = true

      c.headers["Content-Type"] = "application/x-www-form-urlencoded"
      c.headers["charset"] = "Windows-31J"
      c.headers["User-Agent"] = "curl_php"

      c.http_post()

      self.response_code = c.response_code
      self.body_str      = Iconv.conv('utf-8','Windows-31J', c.body_str)
      self.header_str    = c.header_str
      self.request       = c

      log("URL: #{url}")
      log("ResponseCode: #{response_code}")
      log("BODY: #{body_str}")
      log("HEAD: #{header_str}\n\n")

      return self
    end

    def log(str)
      if File.exist?(Paygent.log_output_path)
        File.open(Paygent.log_output_path, "a") do |file|
          file.puts "[#{process_id}][#{params[:trading_id]}] #{str}"
        end
      end
    end

    def success_response?
      response_code.to_i == 200
    end

    def success_processed?
      body_hash[:result].to_i != 1
    end

    def body_hash
      hash = {}
      body_str.scan(/\n(\w+)=(<!DOCTYPE.*?<\/HTML>|.*?)\r/m) { hash.update($1 => $2) }
      hash.with_indifferent_access
    end
  end
end
