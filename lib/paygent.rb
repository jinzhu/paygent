require "paygent/version"

module Paygent
  attr_accessor :client_file_path, :ca_file_path, :log_output_path, :debug_flg, :default_id, :default_password, :timeout, :select_max_cnt

  Paygent.client_file_path = ""
  Paygent.ca_file_path     = ""
  Paygent.log_output_path  = File.join(Rails.root, 'log/paygent.log')
  Paygent.debug_flg        = 0
  Paygent.default_id       = ""
  Paygent.default_password = ""
  Paygent.timeout          = 0
  Paygent.select_max_cnt   = 0

  def self.init
    # Init Logger
  end
end

# w/ 3D code
# w/o 3D code
