module ApplicationHelper
  def markdown_render(md)
    renderer = Redcarpet::Render::HTML.new(filter_html: true, hard_wrap: true, space_after_headers: true)
    markdown = Redcarpet::Markdown.new(renderer, no_intra_emphasis: true, fenced_code_blocks: true)

    markdown.render(md).html_safe
  end

  # alertを表示する
  def render_alert
    capture do
      flash.each do |key, value|
        concat simple_format(value, { class: "alert alert-#{key == 'notice' ? 'success' : 'danger'}" }, { wrapper_tag: 'div' })
      end
    end
  end
end
