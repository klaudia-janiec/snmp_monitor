# frozen_string_literal: true

require "active_record"
require "attr_encrypted"

class Agent < ActiveRecord::Base
  attr_encrypted :auth_password, key: ENV.fetch("SECRET_KEY_BASE")
  attr_encrypted :priv_password, key: ENV.fetch("SECRET_KEY_BASE")

  validates_presence_of :host, :port, :username, :auth_password, :priv_password, :auth_protocol, :priv_protocol
end
