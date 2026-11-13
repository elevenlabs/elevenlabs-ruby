# frozen_string_literal: true

module Elevenlabs
  module Types
    module ConfigEntityType
      extend ::Elevenlabs::Internal::Types::Enum

      NAME = :name
      NAME_NAME_GIVEN = :'name.name_given'
      NAME_NAME_FAMILY = :'name.name_family'
      NAME_NAME_OTHER = :'name.name_other'
      EMAIL_ADDRESS = :email_address
      CONTACT_NUMBER = :contact_number
      DOB = :dob
      AGE = :age
      RELIGIOUS_BELIEF = :religious_belief
      POLITICAL_OPINION = :political_opinion
      SEXUAL_ORIENTATION = :sexual_orientation
      ETHNICITY_RACE = :ethnicity_race
      MARITAL_STATUS = :marital_status
      OCCUPATION = :occupation
      PHYSICAL_ATTRIBUTE = :physical_attribute
      LANGUAGE = :language
      USERNAME = :username
      PASSWORD = :password
      URL = :url
      ORGANIZATION = :organization
      FINANCIAL_ID = :financial_id
      FINANCIAL_ID_PAYMENT_CARD = :'financial_id.payment_card'
      FINANCIAL_ID_PAYMENT_CARD_PAYMENT_CARD_NUMBER = :'financial_id.payment_card.payment_card_number'
      FINANCIAL_ID_PAYMENT_CARD_PAYMENT_CARD_EXPIRATION_DATE = :'financial_id.payment_card.payment_card_expiration_date'
      FINANCIAL_ID_PAYMENT_CARD_PAYMENT_CARD_CVV = :'financial_id.payment_card.payment_card_cvv'
      FINANCIAL_ID_BANK_ACCOUNT = :'financial_id.bank_account'
      FINANCIAL_ID_BANK_ACCOUNT_BANK_ACCOUNT_NUMBER = :'financial_id.bank_account.bank_account_number'
      FINANCIAL_ID_BANK_ACCOUNT_BANK_ROUTING_NUMBER = :'financial_id.bank_account.bank_routing_number'
      FINANCIAL_ID_BANK_ACCOUNT_SWIFT_BIC_CODE = :'financial_id.bank_account.swift_bic_code'
      FINANCIAL_ID_FINANCIAL_ID_OTHER = :'financial_id.financial_id_other'
      LOCATION = :location
      LOCATION_LOCATION_ADDRESS = :'location.location_address'
      LOCATION_LOCATION_CITY = :'location.location_city'
      LOCATION_LOCATION_POSTAL_CODE = :'location.location_postal_code'
      LOCATION_LOCATION_COORDINATE = :'location.location_coordinate'
      LOCATION_LOCATION_STATE = :'location.location_state'
      LOCATION_LOCATION_COUNTRY = :'location.location_country'
      LOCATION_LOCATION_OTHER = :'location.location_other'
      DATE = :date
      DATE_INTERVAL = :date_interval
      UNIQUE_ID = :unique_id
      UNIQUE_ID_GOVERNMENT_ISSUED_ID = :'unique_id.government_issued_id'
      UNIQUE_ID_ACCOUNT_NUMBER = :'unique_id.account_number'
      UNIQUE_ID_VEHICLE_ID = :'unique_id.vehicle_id'
      UNIQUE_ID_HEALTHCARE_NUMBER = :'unique_id.healthcare_number'
      UNIQUE_ID_HEALTHCARE_NUMBER_MEDICAL_RECORD_NUMBER = :'unique_id.healthcare_number.medical_record_number'
      UNIQUE_ID_HEALTHCARE_NUMBER_HEALTH_PLAN_BENEFICIARY_NUMBER = :'unique_id.healthcare_number.health_plan_beneficiary_number'
      UNIQUE_ID_DEVICE_ID = :'unique_id.device_id'
      UNIQUE_ID_UNIQUE_ID_OTHER = :'unique_id.unique_id_other'
      MEDICAL = :medical
      MEDICAL_MEDICAL_CONDITION = :'medical.medical_condition'
      MEDICAL_MEDICATION = :'medical.medication'
      MEDICAL_MEDICAL_PROCEDURE = :'medical.medical_procedure'
      MEDICAL_MEDICAL_MEASUREMENT = :'medical.medical_measurement'
      MEDICAL_MEDICAL_OTHER = :'medical.medical_other'

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
