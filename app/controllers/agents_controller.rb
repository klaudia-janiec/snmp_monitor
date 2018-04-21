# frozen_string_literal: true

require "sinatra/json"
require_relative "base_controller"
require_relative "../services/system_overview"

class AgentsController < BaseController
  helpers do
    def to_gb(size)
      (size / 1_000_000.0).round(2)
    end
  end

  namespace "/agents" do
    get "/" do
      # TODO: After adding DB we should do there just: Agent.all.map { |agent| SystemOverview.new(agent).call }
      systems = [1, 2].map { |id| SystemOverview.new("10.10.10.#{id}").call}
      # systems_overview = [SystemOverview.new.call]

      haml "agents/index".to_sym, locals: { systems_overview: systems }
    end

    get "/:id" do
      # TODO: After moving agents to DB we should do like:
      # agent = Agent.find(params[:id])
      # system_overview = SystemOverview.new(agent).call
      system_overview = SystemOverview.new("10.10.10.#{params[:id]}").call

      json system_overview
    end
  end
end
