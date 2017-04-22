class BindersController < ApplicationController
  def index
    render json: Binder.all
  end

  def show
    render json: binder
  end

  private

  def binder
    Binder.find_by!(key: params[:binder_key])
  end
end
