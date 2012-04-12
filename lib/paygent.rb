module Paygent
  class << self
    attr_accessor :client_file_path, :ca_file_path, :log_output_path, :debug_flg, :timeout, :select_max_cnt, :cert_password
    attr_accessor :merchant_id, :default_id, :default_password, :telegram_version
  end

  Paygent.client_file_path = "config/paygent/client_mdev_20090123.pem"
  Paygent.ca_file_path     = "config/paygent/curl-ca-bundle.crt"
  Paygent.cert_password    = "changeit"
  Paygent.log_output_path  = "log/paygent.log"
  Paygent.debug_flg        = 0
  Paygent.default_id       = ""
  Paygent.default_password = ""
  Paygent.timeout          = 2000
  Paygent.select_max_cnt   = 2000

  def self.init
    Paygent::Request.new
  end
end

require "paygent/request"
