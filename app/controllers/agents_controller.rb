# frozen_string_literal: true

require "sinatra/json"
require_relative "base_controller"
require_relative "../services/system_overview"
require_relative "../models/agent"

class AgentsController < BaseController
  helpers do
    def to_gb(size)
      (size / 1_000_000.0).round(2)
    end
  end

  namespace "/agents" do
    get "/" do
      systems_overview = Agent.all.order(:id).pluck(:id).map { |agent_id| SystemOverview.new(agent_id).call }

      respond_with "agents/index".to_sym, { systems_overview: systems_overview }
      respond_with systems_overview
    end

    get "/:id" do
      json SystemOverview.new(params[:id]).call
    end
  end
end
