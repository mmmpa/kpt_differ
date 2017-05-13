class Api::Markdowns::DiffController < ApplicationController
  DIFFER = Markdiff::Differ.new

  def create
    render json: {
      html: DIFFER.render(
        MarkdownRender.run(params[:a]),
        MarkdownRender.run(params[:b])
      ).to_html,
    }
  end
end
