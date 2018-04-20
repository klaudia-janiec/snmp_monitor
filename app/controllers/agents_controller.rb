# frozen_string_literal: true

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
      locals = SystemOverview.new.call

      haml "agents/index".to_sym, locals: { **locals }
    end
  end
end
