require 'curb'
require 'iconv'

module Paygent
  class Request
    attr_accessor :_params, :body_str, :header_str, :response_code, :request

    def initialize(option={})
      self._params ||= {}
      self._params.update(option)
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

    def post
      # $this->replaceTelegramKana();
      # $this->validateTelegramLengthCheck();

      c = Curl::Easy.new("https://mdev.paygent.co.jp/n/card/request")
      c.cacert          = Paygent.ca_file_path
      c.cert            = Paygent.client_file_path
      c.certpassword    = Paygent.cert_password
      c.connect_timeout = Paygent.timeout
      c.verbose         = true
      c.ssl_verify_host = false
      c.multipart_form_post = true

      c.headers["Content-Type"] = "application/x-www-form-urlencoded"
      c.headers["charset"] = "Windows-31J"
      c.headers["User-Agent"] = "curl_ruby"

      c.post_body = params.map{|f,k| "#{c.escape(f)}=#{c.escape(k)}"}.join('&')

      c.http_post()

      self.response_code = c.response_code
      self.body_str      = Iconv.conv('utf-8','Windows-31J', c.body_str)
      self.header_str    = c.header_str
      self.request       = c
      self
    end

    def success?
      response_code == 200
    end

    def body_hash
      body_str.split("\r\n").inject({}) do |s, str|
        items = str.split("=", 2)
        s.update(items[0] => items[1]) if items.size == 2
        s
      end
    end
  end
end
