# frozen_string_literal: true

module Elevenlabs
  module Types
    module LenientCurrency
      extend ::Elevenlabs::Internal::Types::Enum

      USD = :USD
      EUR = :EUR
      GBP = :GBP
      PLN = :PLN
      CAD = :CAD
      AUD = :AUD
      CHF = :CHF
      SEK = :SEK
      NOK = :NOK
      DKK = :DKK
      ISK = :ISK
      CZK = :CZK
      HUF = :HUF
      RON = :RON
      BGN = :BGN
      JPY = :JPY
      CNY = :CNY
      TWD = :TWD
      INR = :INR
      BRL = :BRL
      MXN = :MXN
      KRW = :KRW
      SGD = :SGD
      HKD = :HKD
      NZD = :NZD
      ZAR = :ZAR
      AED = :AED
      SAR = :SAR
      QAR = :QAR
      KWD = :KWD
      ILS = :ILS
      TRY = :TRY
      THB = :THB
      IDR = :IDR
      MYR = :MYR
      PHP = :PHP
      VND = :VND
      BDT = :BDT
      RUB = :RUB
      UAH = :UAH
      CLP = :CLP
      COP = :COP
      ARS = :ARS
      PEN = :PEN
      EGP = :EGP
      NGN = :NGN
      KES = :KES
      PKR = :PKR
      GEL = :GEL

      def self.load(str)
        coerce(::JSON.parse(str, symbolize_names: true))
      end

      def self.dump(value)
        coerced = coerce(value)
        ::JSON.generate(coerced.nil? || !coerced.respond_to?(:to_h) ? coerced : coerced.to_h)
      end
    end
  end
end
