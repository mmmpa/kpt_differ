class ReportsController < ApplicationController
  def index
    render json: Report.where(binder_key: params[:binder_key], id: params[:report_id])
  end

  def show
    render json: Report.find(params)
  end

  private

  def report
    Report.find_by!(binder_key: params[:binder_key], id: params[:report_id])
  end
end
