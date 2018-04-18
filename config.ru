require "dotenv/load"
require 'sass/plugin/rack'
Sass::Plugin.options[:style] = :compressed
use Sass::Plugin::Rack

require_relative "app/controllers/agents_controller"

run AgentsController
