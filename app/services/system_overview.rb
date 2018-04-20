# frozen_string_literal: true

require_relative "netsnmp_client_factory"

class SystemOverview
  OID_CODES = {
    system_information: "1.3.6.1.2.1.1.1.0",
    user_cpu_time: "1.3.6.1.4.1.2021.11.9.0",
    system_cpu_time: "1.3.6.1.4.1.2021.11.10.0",
    idle_cpu_time: "1.3.6.1.4.1.2021.11.11.0",
    total_ram: "1.3.6.1.4.1.2021.4.5.0",
    ram_physical_free: "1.3.6.1.4.1.2021.4.6.0",
    ram_total_free: "1.3.6.1.4.1.2021.4.11.0",
    ram_shared: "1.3.6.1.4.1.2021.4.13.0",
    ram_buffered: "1.3.6.1.4.1.2021.4.14.0",
    cached_memory: "1.3.6.1.4.1.2021.4.15.0",
    disk_size: "1.3.6.1.4.1.2021.9.1.6.1",
    disk_available_space: "1.3.6.1.4.1.2021.9.1.7.1",
    disk_space_utilization: "1.3.6.1.4.1.2021.9.1.8.1"
  }.freeze

  attr_reader :netsnmp_client, :agent_id

  def initialize(agent_id)
    @agent_id = agent_id
    @netsnmp_client = NetsnmpClientFactory.create_client(agent_id)
  end

  def call
    OID_CODES.each_with_object({id: agent_id}) do |(key, value), hash|
      hash[key] = netsnmp_client.get(oid: value)
    end
  end
end
