# frozen_string_literal: true

require_relative "netsnmp_client_factory"

class SystemOverview
  OID_CODES = { system_information: "1.3.6.1.2.1.1.1.0" }.freeze

  attr_reader :netsnmp_client

  def initialize
    @netsnmp_client = NetsnmpClientFactory.create_client
  end

  def call
    OID_CODES.each_with_object({}) do |(key, value), hash|
      hash[key] = netsnmp_client.get(oid: value)
    end
  end
end
