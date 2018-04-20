# frozen_string_literal: true

require "sinatra/base"
require "sinatra/namespace"
require 'sinatra/activerecord'
require "sinatra/respond_with"

class BaseController < Sinatra::Base
  register Sinatra::RespondWith
  register Sinatra::ActiveRecordExtension
  register Sinatra::Namespace

  set :views, File.expand_path("../views", __dir__)
  set :public_folder, "public"

  get "/" do
    redirect "/agents/"
  end
end
