# frozen_string_literal: true

require "active_record"

class Agent < ActiveRecord::Base
  validates_presence_of :host, :port, :username, :auth_password, :priv_password, :auth_protocol, :priv_protocol
end
