class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound, with: :e404

  def e404
    header :not_found
  end
end
