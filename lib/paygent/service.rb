module Paygent
  class Service
    @@url ||= {}

    ###ATM決済URL###
    @@url["01"] ||= "https://sandbox.paygent.co.jp/n/atm/request"
    ###クレジットカード決済URL1###
    @@url["02"] ||= "https://sandbox.paygent.co.jp/n/card/request"
    ###クレジットカード決済URL2###
    @@url["11"] ||= "https://sandbox.paygent.co.jp/n/card/request"
    ###コンビニ番号方式決済URL###
    @@url["03"] ||= "https://sandbox.paygent.co.jp/n/conveni/request"
    ###コンビニ帳票方式決済URL###
    @@url["04"] ||= "https://sandbox.paygent.co.jp/n/conveni/request_print"
    ###銀行ネット決済URL###
    @@url["05"] ||= "https://sandbox.paygent.co.jp/n/bank/request"
    ###銀行ネット決済ASPURL###
    @@url["06"] ||= "https://sandbox.paygent.co.jp/n/bank/requestasp"
    ###仮想口座決済URL###
    @@url["07"] ||= "https://sandbox.paygent.co.jp/n/virtualaccount/request"
    ###決済情報照会URL###
    @@url["09"] ||= "https://sandbox.paygent.co.jp/n/ref/request"
    ###決済情報差分照会URL###
    @@url["091"] ||= "https://sandbox.paygent.co.jp/n/ref/paynotice"
    ###キャリア継続課金差分照会URL###
    @@url["093"] ||= "https://sandbox.paygent.co.jp/n/ref/runnotice"
    @@url["094"] ||= "https://sandbox.paygent.co.jp/n/ref/paymentref"
    ###携帯キャリア決済URL###
    @@url["10"] ||= "https://sandbox.paygent.co.jp/n/c/request"
    ###携帯キャリア決済URL（継続課金用）###
    @@url["12"] ||= "https://sandbox.paygent.co.jp/n/c/request"
    ###ファイル決済URL###
    @@url["20"] ||= "https://sandbox.paygent.co.jp/n/o/requestdata"
    ###PayPal決済URL###
    @@url["13"] ||= "https://sandbox.paygent.co.jp/n/paypal/request"
    ###電子マネー決済URL###
    @@url["15"] ||= "https://sandbox.paygent.co.jp/n/emoney/request"


    def self.set_url(kind, url)
      @@url[kind.to_s] = url
    end

    def self.get_url_with_telegram_kind(kind)
      kind_str = kind.to_s
      return @@url[kind_str] if @@url[kind_str]
      kind_str = kind_str.sub(/\w$/,'')
      return @@url[kind_str] if @@url[kind_str]
      return false
    end
  end
end
