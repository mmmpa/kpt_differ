class ReportsController < ApplicationController
  def index
  end

  def show
  end

  def update
  end

  private

  def user
    User.find_by(id: params[:user_id]) || User.new
  end
end
