class Api::MarkdownsController < ApplicationController
  def create
    render json: {
      html: MarkdownRender.run(params[:markdown]),
    }
  end
end
