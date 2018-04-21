# frozen_string_literal: true

require "netsnmp"

class NetsnmpClientFactory
  def self.create_client(ip)
    NETSNMP::Client.new(host: ip,
                        port: ENV.fetch("PORT"),
                        username: ENV.fetch("USERNAME"),
                        auth_password: ENV.fetch("AUTH_PASSWORD"),
                        auth_protocol: ENV.fetch("AUTH_PROTOCOL"),
                        priv_password: ENV.fetch("PRIV_PASSWORD"),
                        priv_protocol: ENV.fetch("PRIV_PROTOCOL"))
  end
end
