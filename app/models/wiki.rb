class Wiki < ActiveRecord::Base

  belongs_to :user

  default_scope { order('created_at DESC') }

  scope :visible_to, -> (user) { user ? all : where(private: false) }

  def is_owned_by?(candidate)
    candidate == user
  end

  def markdown_title
    render_as_markdown title
  end

  def markdown_body
    render_as_markdown body
  end

  private

  def render_as_markdown(markdown)
    renderer = Redcarpet::Render::HTML.new
    extensions = {fenced_code_blocks: true}
    redcarpet = Redcarpet::Markdown.new(renderer, extensions)
    (redcarpet.render markdown).html_safe
  end

end
