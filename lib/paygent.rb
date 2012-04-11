module Paygent
  class << self
    attr_accessor :client_file_path, :ca_file_path, :log_output_path, :debug_flg, :default_id, :default_password, :timeout, :select_max_cnt
  end

  Paygent.client_file_path = ""
  Paygent.ca_file_path     = ""
  Paygent.log_output_path  = "log/paygent.log"
  Paygent.debug_flg        = 0
  Paygent.default_id       = ""
  Paygent.default_password = ""
  Paygent.timeout          = 0
  Paygent.select_max_cnt   = 2000

  def self.init
    Paygent::Request.new
  end
end

require "paygent/request"
