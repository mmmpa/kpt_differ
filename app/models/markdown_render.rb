class MarkdownRender
  class Renderer < Redcarpet::Render::HTML
    def block_code(code, language)
      Pygments.highlight(code, lexer: language)
    end
  end

  RENDERER = Redcarpet::Markdown.new(
    Renderer,
    autolink: true,
    tables: true,
    fenced_code_blocks: true
  )

  class << self
    def run(src)
      RENDERER.render(src.to_s)
    end
  end
end