require 'rest_client'

module Paygent
  module Request
    attr_accessor :_params

    def initialize
    end

    def valid?
    end

    def replaceTelegramKana
    end

    def validateTelegramLengthCheck
    end

    def reqPut(key, value)
      _params ||= []
      _params[key.to_sym] = value
    end

    def reqGet(key)
      params[key.to_sym]
    end

    def params
      {
        :connect_id => Paygent.default_id,
        :connect_password => Paygent.default_password,
        :limit_count => Paygent.select_max_cnt,
        :telegram_kind => "010",
        :telegram_version => "1.0"
      }.merge(_params || {})
    end

    def post
      rest_client = RestClient::Resource.new(
        "https://mdev.paygent.co.jp/n/card/request",
        :ssl_client_cert  =>  OpenSSL::X509::Certificate.new(Paygent.client_file_path),
        :ssl_ca_file      =>  Paygent.ca_file_path,
        :timeout          => Paygent.timeout
      )

      # $this->replaceTelegramKana();
      # $this->validateTelegramLengthCheck();
      #
      # define("HttpsRequestSender__CONTENT_TYPE", "Content-Type=application/x-www-form-urlencoded");
      # define("HttpsRequestSender__HTTP_ENCODING", "charset=Windows-31J");
      # $header[] = HttpsRequestSender__USER_AGENT . ": " . "   curl_php";

      # $header[] = HttpsRequestSender__CONTENT_TYPE;
      # $header[] = HttpsRequestSender__HTTP_ENCODING;
      # $header[] = HttpsRequestSender__USER_AGENT . ": " . "curl_php";


      $this->ch = curl_init($this->url);
      $rslt = $rslt && curl_setopt($this->ch, CURLOPT_HTTP_VERSION, CURL_HTTP_VERSION_1_0 );
      $rslt = $rslt && curl_setopt($this->ch, CURLOPT_RETURNTRANSFER, true);
      $rslt = $rslt && curl_setopt($this->ch, CURLOPT_POST, true);
      $rslt = $rslt && curl_setopt($this->ch, CURLOPT_HEADER, true);

      // 証明書
      $rslt = $rslt && curl_setopt($this->ch, CURLOPT_SSL_VERIFYPEER, true);
      $rslt = $rslt && curl_setopt($this->ch, CURLOPT_SSL_VERIFYHOST, false);
      $rslt = $rslt && curl_setopt($this->ch, CURLOPT_SSLCERT, $this->clientCertificatePath);
      $rslt = $rslt && curl_setopt($this->ch, CURLOPT_SSLKEYPASSWD, $this->KEYSTORE_PASSWORD);
      $rslt = $rslt && curl_setopt($this->ch, CURLOPT_CAINFO, $this->caCertificatePath);

      // タイムアウト
      $rslt = $rslt && curl_setopt($this->ch, CURLOPT_TIMEOUT, $this->timeout);
      $rslt = $rslt && curl_setopt($this->ch, CURLOPT_CONNECTTIMEOUT, $this->proxyConnectTimeout);


      response = rest_client.post(params)
      response.to_str

      # Init Params

      # Pre Post

      # Error Check

      # Post

      # Get Body
    end

    def result
    end
  end
end

# Pay without 3D
# Pay with 3D
# Cancel
