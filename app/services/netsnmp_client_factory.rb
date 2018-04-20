# frozen_string_literal: true

require "netsnmp"

class NetsnmpClientFactory
  def self.create_client(agent_id)
    agent = Agent.find(agent_id)

    NETSNMP::Client.new(host: agent.host,
                        port: agent.port,
                        username: agent.username,
                        auth_password: agent.auth_password,
                        auth_protocol: agent.auth_protocol,
                        priv_password: agent.priv_password,
                        priv_protocol: agent.priv_protocol)
  end
end
