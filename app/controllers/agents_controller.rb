# frozen_string_literal: true

require_relative "base_controller"
require_relative "../services/system_overview"

class AgentsController < BaseController
  namespace "/agents" do
    get "/" do
      locals = SystemOverview.new.call

      haml "agents/index".to_sym, locals: { **locals }
    end
  end
end
