# frozen_string_literal: true

require_relative "base_controller"
require_relative "../services/netsnmp_client_factory"

class AgentsController < BaseController
  namespace "/agents" do
    get "/" do
      client = NetsnmpClientFactory.create_client
      oid = "1.3.6.1.2.1.1.1.0"

      haml "agents/index".to_sym, locals: { agent_name: client.get(oid: oid) }
    end
  end
end
