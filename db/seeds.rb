# frozen_string_literal: true

require File.expand_path("../../app/models/agent", __FILE__)

Agent.create!(
  host: ENV.fetch("HOST"),
  port: ENV.fetch("PORT"),
  username: ENV.fetch("USERNAME"),
  auth_password: ENV.fetch("AUTH_PASSWORD"),
  priv_password: ENV.fetch("PRIV_PASSWORD"),
  auth_protocol: ENV.fetch("AUTH_PROTOCOL"),
  priv_protocol: ENV.fetch("PRIV_PROTOCOL")
)
